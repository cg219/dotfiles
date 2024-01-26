print("Setting up Mac");
print("Please enter information for Git")

local config = {}

local function reloadshell()
    os.execute("zsh -c source ~/.zshrc")
end

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
end

local function setupgit()
   print("Setting up git")

   os.execute(string.format("git config --global user.name %s", config.git.name))
   os.execute(string.format("git config --global user.email %s", config.git.email))
   os.execute("git config --global init.defaultBranch main")
end

local function setupdotfiles()
    print("Setting up dotfiles")

    local home = os.getenv("HOME");

    os.execute("cd ~; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh")
    os.execute("cd ~; mkdir websites; mkdir development; mkdir apps; mkdir .config")
    os.execute("cd ~; mkdir -p .local/share/nvim/site/pack/packer/start")
    os.execute("cd ~; git clone git@github.com:cg219/dotfiles.git; git clone git@github.com:cg219/sublime-settings.git; git clone --depth 1 https://github.com/wbthomason/packer.nvim")
    os.execute("cd ~; sudo cp -R packer.nvim ~/.local/share/nvim/site/pack/packer/start/")
    os.execute("ln -s ~/dotfiles/.zshrc ~/.zshrc")
    os.execute("ln -s ~/dotfiles/.zshenv ~/.zshenv")
    os.execute("ln -s ~/dotfiles/nvim ~/.config/nvim")
    os.execute("trash ~/.zprofile")
    os.execute("subl")
    os.execute("osascript -e 'quit app \"Sublime Text\"'")
    os.execute(string.format("trash \"%s/Library/Application Support/Sublime Text/Packages/User\"", home))
    os.execute("sudo cp -R ~/sublime-settings ~/User; trash ~/sublime-settings")
    os.execute(string.format("ln -s ~/User \"%s/Library/Application Support/Sublime Text/Packages\"", home))
end

local function setupjsenv()
    local nodes = {
        { "lts/iron", "latest" },
        { "lts/hydrogen", "lts"},
        { "lts/gallium", "legacy"}
    }

    print("Installing Deno")
    os.execute("curl -fsSL https://deno.land/install.sh | zsh")

    local npm_installs = "firebase-tools ghost-cli nodemon pkg"

    for _, value in pairs(nodes) do
        print(string.format("Installing NodeJS: %s", value[1]))

        os.execute(string.format("zsh -c eval \"fnm env\" && fnm install %s", value[1]))
        os.execute(string.format("zsh -c eval \"fnm env\" && fnm alias %s %s", value[1], value[2]))
        os.execute(string.format("zsh -c eval \"fnm env\" && fnm use %s; npm i -g %s", value[2], npm_installs))
    end

    reloadshell()
end

local function setupmacapps()
    print("Install App Store apps...")
    os.execute("mas install 1116599239") -- NordVPN
    os.execute("mas install 497799835") -- Xcode
end

local function setupdefaults()
    local calls = {
        "sudo spctl --master-disable",
        "defaults write NSGlobalDomain AppleInterfaceStyle -string \"Dark\"",
        "defaults write NSGlobalDomain AppleKeyboardUIMode -int 0",
        "defaults write com.apple.keyboard.fnState -int 1",
        "defaults write com.apple.mouse.scaling -float 1.5",
        "defaults write com.apple.swipescrolldirection -int 1",
        "defaults write com.apple.trackpad.forceClick -int 1",
        "defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true",
        "defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true",
        "defaults write com.apple.dock autohide -bool true",
        "defaults write com.apple.dock \"dashboard-in-overlay\" -int 1",
        "defaults write com.apple.dock \"expose-group-apps\" -int 0",
        "defaults write com.apple.dock \"expose-group-by-app\" -int 0",
        "defaults write com.apple.dock largesize -int 96",
        "defaults write com.apple.dock magnification -bool true",
        "defaults write com.apple.dock mineffect -string \"scale\"",
        "defaults write com.apple.dock orientation -string \"left\"",
        "defaults write com.apple.dock tilesize -int 31",
        "defaults write com.apple.dock mineffect -string \"scale\"",
        "defaults write com.apple.dock mineffect -string \"scale\"",
        "defaults write com.apple.dock mineffect -string \"scale\"",
        "defaults write com.apple.dock mineffect -string \"scale\"",
        "killall Finder"
    }

    for _,call in pairs(calls) do
        os.execute(string.format("%s", call))
    end
end

setupssh()

print("Hit [Enter] to continue once public key is added...")
os.execute("open https://github.com/settings/keys")
io.read()

setupgit()
setupdotfiles()
setupjsenv()

print("Hit [Enter] after you sign in to the App Store...")
io.read()

-- setupmacapps()
setupdefaults()

print("All Set!!!")
