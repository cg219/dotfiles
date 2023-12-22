sudo apt update -y
sudo apt upgrade -y
sudo apt install zsh git neovim curl unzip -y
echo Y | sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
wget -P /tmp https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf /tmp/go1.16.7.linux-amd64.tar.gz
wget -O - https://fnm.vercel.app/install | zsh --skip-shell
