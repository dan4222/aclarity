#!/bin/bash
sudo apt-get update && apt-get upgrade -y
sudo apt-get install net-tools ssh iputils-ping nano wget unzip software-properties-common curl git zsh -y
service ssh restart
timedatectl set-timezone America/New_York

# Check and switch to zsh
if [ "$SHELL" != "/usr/bin/zsh" ]; then
  sudo chsh -s /usr/bin/zsh $USER
fi

# Install Alacritty
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt install -y alacritty

# Set up Alacritty configuration
# Define the URL of the alacritty.yml file in the repository
url="https://raw.githubusercontent.com/dan4222/aclarity/main/alacritty.yml"

# Define the destination where you want to place the file
destination=" ~/.config/alacritty/alacritty.yml"

# Use curl to download the file and place it in the destination
curl -L $url -o $destination


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
qdbus org.kde.ksmserver /KSMServer logout 0 0 0