print("Setting up Mac");
print("Please enter information for Git")

local config = {}
local function setupssh()
    local keyname = "github_ed25519"

    config.git = {}

    io.write("Name: ")
    config.git.name = io.read()

    io.write("Email: ")
    config.git.email = io.read()

    print("Creating SSH Key...")
    os.execute(string.format("ssh-keygen -t ed25519 -b 4096 -C \"github\" -f ~/.ssh/%s", keyname))

    print("SSH created")
    print("Configuring SSH...")

    os.execute("ssh-agent -s");

    local sshentry = [[
    Host *
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/%s
    ]]

    local sshconfig = io.open("~/.ssh/config", "w")

    if sshconfig then
        sshconfig:write(sshentry)
        sshconfig:close()
    end

    os.execute(string.format("ssh-add -K ~/.ssh/%s", keyname))
    os.execute(string.format("cat ~/.ssh/%s.pub | pbcopy", keyname))

    print("SSH configured. Public Key has been copoied to the clipboard.")
    print("Add the key to your Github Settings.")
    print("Hit [Enter] to continue once public key is added...")

    os.execute("open https://github.com/settings/keys")
    io.read()
end

local function setupgit()
   print("Setting up git")

   os.execute(string.format("git config --global user.name %s", config.git.name))
   os.execute(string.format("git config --global user.email %s", config.git.email))
   os.execute("git config --global init.defaultBranch main")
end

setupssh()
setupgit()

