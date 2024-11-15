import { walk } from "@std/fs";
import { join } from "@std/path/join";
import { distinctBy } from "@std/collections";

const home = Deno.env.get("HOME") ?? "/";
const devDir = await Array.fromAsync(walk(join(home, "development"), {
    maxDepth: 1,
    includeFiles: false
}))

const webDir = await Array.fromAsync(walk(join(home, "websites"), {
    maxDepth: 1,
    includeFiles: false
}))

const atDir = await Array.fromAsync(walk(join(home, "development", "ActiveTheory"), {
    maxDepth: 1,
    includeFiles: false
}))

const entries = [...devDir, ...webDir, ...atDir]
const files  = distinctBy(entries, (entry) => entry.path)
const filesAsList = files.map((f) => f.name).join("\n")
const fzf = new Deno.Command("fzf", {
    stdin: "piped",
    stdout: "piped"
})

const p = fzf.spawn()
const pwriter = p.stdin.getWriter()

pwriter.write(new TextEncoder().encode(filesAsList))
pwriter.releaseLock()

await p.stdin.close()

const chosen = new TextDecoder().decode((await p.output()).stdout)

if (!chosen) Deno.exit();

const chosenEntry = files.find((f) => {
    return f.name == chosen.trim()
});

if (!chosenEntry) Deno.exit();

console.log(chosenEntry)

const zellij = new Deno.Command("zellij", {
    args: [
        "a",
        "-c",
        chosenEntry.name
    ]
})

const zellp = zellij.spawn()
await zellp.output()
