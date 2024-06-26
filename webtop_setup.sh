#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install net-tools ssh iputils-ping nano wget unzip software-properties-common curl git zsh -y
sudo service ssh restart
sudo timedatectl set-timezone America/New_York

#allow insecure repos
sudo echo 'APT::Get::AllowUnauthenticated "true";' | sudo tee /etc/apt/apt.conf.d/99allow-insecure

# Path to the zsh executable
ZSH_PATH=$(which zsh)

# Check each user's default shell and change it to Zsh if it's not already Zsh
while IFS=: read -r username _ _ _ _ _ shell
do
    if [ "$shell" != "$ZSH_PATH" ] && [ ! -z "$shell" ]; then
        echo "Changing shell for $username to $ZSH_PATH"
        sudo chsh -s "$ZSH_PATH" "$username"
    fi
done < /etc/passwd

# Install prerequisites for compiling Alacritty
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 desktop-file-utils
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.zshrc
. "$HOME/.cargo/env"

# Clone and compile Alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release

# Install Alacritty
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
cd ..

# Create Alacritty configuration directory and file
mkdir -p ~/.config/alacritty
sudo mv alacritty.toml ~/.config/alacritty/

# Install Nerd Fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh Meslo
cd ..

# Powerlevel10k theme setup
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

# Install exa and zoxide
sudo apt install -y exa
curl -sS https://webinstall.dev/zoxide | bash
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc

# Install and configure tmux
sudo apt install -y tmux
curl -o ~/.tmux.conf https://raw.githubusercontent.com/josean-dev/dev-environment-files/main/.tmux.conf

# Source zshrc to apply changes
source ~/.zshrc

# logout and login to apply changes
#qdbus org.kde.ksmserver /KSMServer logout 0 0 0