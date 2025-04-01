#!/bin/bash

# Install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy necessary dotfiles and configurations safely
rsync -av --progress .config .oh-my-zsh .vim Documents .vimrc .zshrc "$HOME" --exclude '*.bak' --exclude '*.tmp'

# Ensure the X11 configuration directory exists before copying
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp -v Documents/90-touchpad.conf /etc/X11/xorg.conf.d/

# Apply new shell configuration
source "$HOME/.zshrc"

echo "Dotfiles installation complete."

