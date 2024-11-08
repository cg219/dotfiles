const name = "testkey";

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
})

await keygen.spawn().status;

