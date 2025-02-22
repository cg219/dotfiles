import { resolve } from "jsr:@std/path/resolve";
import { parseArgs } from "jsr:@std/cli@1.0.13"
import { parse as yaml } from "jsr:@std/yaml@1.0.5"
import { ensureDir } from "jsr:@std/fs/ensure-dir";
import { dirname } from "jsr:@std/path/dirname";
import { MuxAsyncIterator } from "jsr:@std/async/mux-async-iterator"

type RecodeOptions = {
    file: string[];
    output: string[];
    vbr: string;
    abr: string;
    directory: boolean;
    list: boolean;
    match: string;
    threads: number;
    sequence: boolean;
    cimode: boolean;
}

type YmlList  = {
    base: {
        source?: string;
        target?: string;
    }
    settings: {
        abr?: string;
        vbr?: string;
        threads?: number;
        sequence?: boolean;
        codec?: string;
    }
    list: [{
        source: string;
        target: string;
    }]
}

type Generation = [string, number, number, boolean];

const colorCodes = {
    reset: "\x1b[0m",
    black: "\x1b[38;5;0m",
    red: "\x1b[38;5;1m",
    green: "\x1b[38;5;2m",
    yellow: "\x1b[38;5;3m",
    blue: "\x1b[38;5;4m",
    magenta: "\x1b[38;5;5m",
    cyan: "\x1b[38;5;6m",
    white: "\x1b[38;5;7m",
};

const decoder = new TextDecoder();
const encoder = new TextEncoder();
let codec = "libx265";
let abr = "128k";
let vbr = "1400k";
let threads = 4;
let sequence = true;

for await (const input of Deno.stdin.readable) {
    const data = decoder.decode(input)
    const parsed = yaml(data) as YmlList

    if (abr == "128k" && parsed.settings.abr) abr = parsed.settings.abr
    if (vbr == "1400k" && parsed.settings.vbr) vbr = parsed.settings.vbr
    if (codec == "libx265" && parsed.settings.codec) codec = parsed.settings.codec
    if (!sequence && parsed.settings.sequence) sequence = parsed.settings.sequence
    if (threads == 4 && parsed.settings.threads) threads = parsed.settings.threads

    const iterable = {
        async *[Symbol.asyncIterator]() {
            for (const val of Object.entries(parsed.list)) {
                yield val;
            }
        }
    }

    for await (const [i, value] of iterable) {
        const input = resolve(parsed.base.source ?? Deno.cwd(), value.source);
        const output = resolve(parsed.base.target ?? Deno.cwd(), value.target);

        // await Deno.stdout.write(encoder.encode(`\r${colorCodes.red}Processing file ${colorCodes.yellow}${Number(i) + 1} of ${parsed.list.length}${colorCodes.reset}`))
        // await Deno.stdout.write(encoder.encode(`\n`))
        await run(input, output)
    }
}

function parseProgress(progressChunk: string) : Generation {
    const arr = progressChunk.split(/\r?\n/);
    const line = arr.find((line) => line.includes("progress=")); 

    if (line) {
        const progressVal = line.split("=")[1].trim()

        if (progressVal == "end") {
            return ["", 0, 0, false]
        }

        return ["", 0, 0, true]
    }

    return ["", 0, 0, false]
}

function parseFrames(frameChunk: string, total: number) : Generation {
    let frame;
    const arr = frameChunk.split(/\r?\n/);
    const line = arr.find((line) => line.includes("NUMBER_OF_FRAMES"));

    if (line && total == 0) {
        total = parseInt(line.split(":")[1].trim())
        frame = 0;
    } else if (arr.at(0)?.startsWith("frame=")) {
        frame = parseInt(arr[0].split("fps=")[0].slice(6).trim())
    } else {
        total = total ?? 0
        frame = 0
    }

    const percent = (frame / total) * 100
    const pstring = percent >= 0 ? percent.toFixed(0) : "0";

    return [pstring, frame, total, true]
}

function getProgress(frames: ReadableStream, progress: ReadableStream) {
    const mux = new MuxAsyncIterator<Generation>();
    const decoder = new TextDecoder();
    let total = 0;

    async function* generateFrames(s: ReadableStream) {
        let last = 0
        for await( const chunk of s) {
            const v = parseFrames(decoder.decode(chunk), total)

            if (total == 0) {
                total = v[2]
            }

            if (v[1] < last) {
                v[1] = last
            } else {
                last = v[1];
            }

            yield v;
        };
    }

    async function* generateProgress(s: ReadableStream) {
        for await( const chunk of s) {
            const v = parseProgress(decoder.decode(chunk))

            if (v[0] == "" && v[1] == 0 && v[2] == 0 && v[3] == true) continue;

            yield v;
        };
    }

    mux.add(generateFrames(frames))
    mux.add(generateProgress(progress))

    return mux.iterate()
}

function getBar(percent: number, width: number = 50) {
    const fill = Math.floor((percent / 100) * width);

    if (percent >= 100) {
        return `${colorCodes.cyan}Complete: ${colorCodes.yellow}[${colorCodes.green}${"X".repeat(fill).padEnd(width)}${colorCodes.yellow}] ${colorCodes.green}${percent}${colorCodes.white}%${colorCodes.reset}`
    }

    return `${colorCodes.red}Processing: ${colorCodes.yellow}[${colorCodes.green}${"X".repeat(fill).padEnd(width)}${colorCodes.yellow}] ${colorCodes.green}${percent}${colorCodes.white}%${colorCodes.reset}`
}


async function run(input: string, output: string) {
    const firstPass:string[] = [];
    // const secondPass:string[] = [];

    firstPass.push('-y');
    firstPass.push('-i');
    firstPass.push(input);
    firstPass.push('-map');
    firstPass.push('0');
    firstPass.push('-c:v');
    firstPass.push(codec);
    firstPass.push('-b:v');
    firstPass.push(vbr)
    firstPass.push('-c:a');
    firstPass.push('aac');
    firstPass.push('-b:a');
    firstPass.push(abr)
    firstPass.push('-c:s');
    firstPass.push('copy');
    firstPass.push('-threads');
    firstPass.push(threads.toString())
    firstPass.push('-progress');
    firstPass.push('pipe:1');
    firstPass.push(output);

    const passes = [firstPass];
    const passMap = new Map();

    passMap.set(firstPass, 'first pass');
    // passMap.set(secondPass, 'second pass');

    await ensureDir(dirname(output))
    console.log(`%cinput%c: %c${input}%c`, "color: cyan", "color: normal", "color: magenta", "color: normal")
    let cmd: Deno.Command
    let passrun: Deno.ChildProcess

    for await (const pass of passes) {
        cmd = new Deno.Command("ffmpeg", {
            stdout: "piped",
            stderr: "piped",
            args: pass
        });

        passrun = cmd.spawn()

        const [o1, o2] = passrun.stdout.tee()
        const [e1, e2] = passrun.stderr.tee()

        // o1.pipeTo(Deno.stdout.writable, { preventAbort: true, preventClose: true })
        // e1.pipeTo(Deno.stderr.writable, { preventAbort: true, preventClose: true })

        const encoder = new TextEncoder()

        for await (const [current, f, t, e] of getProgress(e2, o2)) {
            // if (passMap.get(pass) == 'first pass') {
            // Deno.stdout.write(encoder.encode(`\rProcessing... ${current}% : ${f}/${t}: continue: ${e}`))

            if (!e) break;
            Deno.stdout.write(encoder.encode(`\r${getBar(Number(current))}`))
            // console.log(Math.round(current * 100));
            // } else {
            //     progress.position(Math.round(50 + (current * 100 * .5)));
            // }
        }

        try {
            await passrun.status;
            Deno.stdout.write(encoder.encode(`\r${getBar(100)}\n`))
        } catch (err) {
            console.log(err)
        }
    }
}
