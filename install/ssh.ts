const name = "testkey";
const entry = `
    Host *
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/${name}`;

const keygen = new Deno.Command("ssh-keygen", {
    args: [
       "-t",
        "ed25519",
        `-f`,
        `./${name}`,
        "-C",
        "issatess",
        "-b",
        "4096"
    ],
    stdin: "inherit",
    stdout: "inherit"
});

const config = new Deno.Command("~/.ssh/config", entry, { create: true, append: true });

const agent = new Deno.Command("ssh-agent", {
    args: ["-s"]
});


await keygen.spawn().status;
await config.spawn().status;
await agent.spawn().status;

