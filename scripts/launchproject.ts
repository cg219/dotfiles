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
const fzf = new Deno.Command("fzf", { stdin: "piped", stdout: "piped" })
const fzfp = fzf.spawn()
const pwriter = fzfp.stdin.getWriter()
const filesAsList = files.map((f) => f.name).join("\n")

pwriter.write(new TextEncoder().encode(filesAsList))
pwriter.releaseLock()

await fzfp.stdin.close()

const chosen = new TextDecoder().decode((await fzfp.output()).stdout)

if (!chosen) Deno.exit();

const chosenEntry = files.find((f) => {
    return f.name == chosen.trim()
});

if (!chosenEntry) Deno.exit();

await new Deno.Command("zellij", {
    args: [
        "attach",
        "-c",
        chosenEntry.name,
        "options",
        "--default-cwd",
        chosenEntry.path,
        "--default-layout",
        "dev-2pane",
    ]
}).spawn().output()

