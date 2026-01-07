#!/usr/bin/env bash

# exit on errors
set -euo pipefail

# change directory to sourcebuild
cd /home/cream/Documents/sourcebuild

# install MineSDDM
# you can customize the installation path, which will then be your source path
git clone https://github.com/Davi-S/sddm-theme-minesddm.git ~/Documents/sourcebuild/sddm-theme-minesddm
sudo cp -r ~/Documents/sourcebuild/sddm-theme-minesddm /usr/share/sddm/themes/

# Then adjust the theme configuration file for SDDM
sudo sed -i 's/Theme=/Theme=minesddm/' /etc/sddm.conf

# The above line just does this: (changes the "Current" parameter to "minesddm")
# [Theme]
# Current=minesddm

# install Minecraft World Loading KDE Splash
git clone https://github.com/Samsu-F/minecraftworldloading-kde-splash ~/.local/share/plasma/look-and-feel/minecraftworldloading-kde-splash

# install Minecraft Main Menu for GRUB
git clone https://github.com/Lxtharia/minegrub-theme.git
cd minegrub-theme

# Optionally choose background
./choose_background.sh

# change paths in minegrub-update.service file to change all occurences of "grub" to "grub2"
sudo sed -i 's/\/boot\/grub/\/boot\/grub2/' ./minegrub-update.service

# Copy Minecraft Main Menu themes to GRUB
sudo cp -ruv ./minegrub /boot/grub/themes/

# install Minecraft World Selection for GRUB
git clone https://github.com/Lxtharia/minegrub-world-sel-theme.git && cd minegrub-world-sel-theme
sudo ./install_theme.sh

# install double-minegrub-menu
git clone https://github.com/Lxtharia/double-minegrub-menu.git
cd double-minegrub-menu
sudo ./install.sh
