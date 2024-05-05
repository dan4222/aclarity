# Webtop Setup

This repository contains scripts and configuration files to set up a webtop environment.

## Files

- `webtop_setup.sh`: This is a bash script that sets up the environment. It installs necessary packages, clones and builds Alacritty, sets up Zsh with plugins and themes, and configures tmux.
- `alacritty.toml`: This is a configuration file for Alacritty terminal emulator.

## Usage

To use the setup script, run the following command in your terminal:

```
./webtop_setup.sh
```


After running the script, log out and log back in to apply the changes.

# Configurations
The webtop_setup.sh script performs the following configurations:

- Updates and upgrades the system packages.
- Installs necessary packages including net-tools, ssh, iputils-ping, nano, wget, unzip, software-properties-common, curl, git, zsh.
- Sets the timezone to America/New_York.
- Changes the default shell to Zsh for all users.
- Installs prerequisites for compiling Alacritty.
- Clones and compiles Alacritty and installs it.
- Moves the alacritty.toml configuration file to the Alacritty configuration directory.
- Installs Nerd Fonts.
- Sets up the Powerlevel10k theme for Zsh.
- Clones and sets up Zsh plugins: zsh-autosuggestions and zsh-syntax-highlighting.
- Installs and configures exa and zoxide.
- Installs and configures tmux.

## Alacritty Configuration
The alacritty.toml file contains configurations for Alacritty terminal emulator. It sets the terminal environment, window properties, font size, and other settings.