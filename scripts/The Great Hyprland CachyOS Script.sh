#!/usr/bin/env bash
# Building from the ground up for Fedora

# Dependencies for sherlock
paru -S git gtk4 gtk4-layer-shell dbus sqlite librsvg gdk-pixbuf2

# Install rust via this curl script
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Note: sqlite package provides libsqlite3-dev

# Go to temp directory
cd /tmp

# Clone the repository
git clone https://github.com/skxxtz/sherlock.git
cd sherlock

# Build sherlock
cargo build --release

# Install the binary
sudo cp target/release/sherlock /usr/local/bin/

# (Optional) Remove the build directory
rm -rf /tmp/sherlock

# Installing sherlock-wiki to access Wikipedia
# Go to temp directory
cd /tmp

# Clone the repository
git clone https://github.com/Skxxtz/sherlock-wiki.git
cd sherlock-wiki

# Build sherlock-wiki
cargo build --release

mkdir -p ~/.config/sherlock/scripts/
cp target/release/sherlock-wiki ~/.config/sherlock/scripts/

# Add the following to sherlock's fallback.json after
# {
#     "name": "Wikipedia Search",
#     "alias": "wiki",
#     "type": "bulk_text",
#     "on_return": "next",
#     "async": true,
#     "args": {"icon": "wikipedia", "exec": "~/.config/sherlock/scripts/sherlock-wiki", "exec-args": "'{keyword}'"},
#     "priority": 0
# }

# (Optional) Remove the build directory
rm -rf /tmp/sherlock-wiki

# Installing sherlock-confetti

# Install dependencies for sherlock-confetti
paru -S libxkbcommon vulkan-icd-loader mesa wayland wayland-protocols

# Go to temp directory
cd /tmp

# Clone the repository
git clone https://github.com/skxxtz/sherlock-confetti.git
cd sherlock-confetti

# Build sherlock-confetti
cargo build --release

# Install the binary
sudo cp target/release/confetti /usr/local/bin/

# (Optional) Remove the build directory
rm -rf /tmp/sherlock-confetti

# Installing sherlock-dict to access dictionary entries via dict.org

# Go to temp directory
cd /tmp

# Clone the repository
git clone https://github.com/MoonBurst/sherlock_dict_rs.git

# Change directory into the newly created one
cd sherlock_dict_rs

# Build the binary
cargo build --release

# Move the binary to the scripts directory
mv target/release/sherlock-dictionary ~/.config/sherlock/scripts/

# Add the following to sherlock's fallback.json after (and running it with "define $words")
# {
#     "name": "Dictionary Lookup",
#     "alias": "define",
#     "type": "bulk_text",
#     "async": true,
#     "args": {
#         "icon": "dictionary",
#         "exec": "~/.config/sherlock/scripts/sherlock-dictionary",
#         "exec-args": "{keyword}"
#     },
#     "priority": 0,
#     "shortcut": false
# }

# (Optional) Remove the build directory
rm -rf /tmp/sherlock-dict

# Installing wayshot as a Rust-native alternative to hyprshot

# Install dependencies for wayshot
paru -S scdoc rustup make

# Install wayshot
cd ~/Documents/sourcebuild
git clone https://github.com/waycrate/wayshot && cd wayshot
make setup
make
sudo make install
# rm -rf /tmp/wayshot

# Go to temp directory
cd /tmp

# Clone the repository
git clone https://github.com/skxxtz/sherlock-clipboard.git
cd sherlock-clipboard

# Build the binary
cargo build --release

# Install the binary
sudo cp target/release/sherlock-clp /usr/local/bin/

# (Optional) Remove the build directory
rm -rf /tmp/sherlock-clipboard

# ironbar installation
# build requirements for ironbar
sudo pacman -S gtk4 gtk4-layer-shell dbus pkg-config
# for http support
sudo pacman -S openssl
# for volume support
sudo pacman -S libpulse
# for keyboard support
sudo pacman -S libinput
# for lua/cairo support
sudo pacman -S luajit lua51-lgi

# runtime requirements for ironbar
# for lua/cairo support
sudo pacman -S lua51-lgi

cd /tmp
git clone https://github.com/jakestanger/ironbar.git
cd ironbar
cargo build --release # you can add or remove --locked flag
# change path to wherever you want to install
install target/release/ironbar ~/.local/bin/ironbar # or /usr/local/bin/
rm -rf /tmp/ironbar

# Install meson, a build system used by SwayOSD
sudo pacman -S meson

# Dependencies for SwayOSD (if compiling from source)
sudo pacman -S sassc

# SwayOSD (OSD for Hyprland)
cd /tmp
git clone --recursive https://github.com/ErikReider/SwayOSD.git
cd SwayOSD
# Please note that the command below might require `--prefix /usr` on some systems
meson setup build --buildtype release
meson compile -C build
meson install -C build
rm -rf /tmp/SwayOSD

# Installing an updated fork of rsmatrix, a cmatrix Rust clone
cd /tmp
git clone https://github.com/DeltaCream/rsmatrix.git
cd rsmatrix
cargo build --release
sudo cp target/release/rsmatrix /usr/local/bin
rm -rf /tmp/rsmatrix

# curl script to install unimatrix, a Unicode variant based on cmatrix
sudo curl -L https://raw.githubusercontent.com/will8211/unimatrix/master/unimatrix.py -o /usr/local/bin/unimatrix
sudo chmod a+rx /usr/local/bin/unimatrix

# Installing cmatrix, the original Matrix-like effect simulator on the terminal
sudo pacman -S cmatrix

# pacman dependencies for wleave
sudo pacman -S gtk4-layer-shell gtk4 librsvg libadwaita

# wleave (Wayland logout prompt utility based from wlogout, written in Rust)
git clone https://github.com/AMNatty/wleave.git
cd wleave
cargo build --release
sudo cp target/release/wleave /usr/bin

# Optionally copy wleave.fish
sudo cp completions/wleave.fish /usr/share/fish/vendor_completions.d/wleave.fish

# Optionally copy wleave icons to /usr/share
sudo mkdir -p /usr/share/wleave/icons # create the wleave/icons directory on /usr/share just in case
sudo cp icons/* /usr/share/wleave/icons # or more specifically icons/*.svg

# awww (Wayland Wallpaper Manager, formerly named swww)
git clone https://codeberg.org/LGFae/awww.git
cd awww
cargo build --release
sudo cp target/release/awww /usr/bin
sudo cp target/release/awww-daemon /usr/bin
# Generate man pages, installing *scdoc* required
./doc/gen.sh
# Move generated man pages to /usr/local/share/man
# Why /usr/local/share instead of /usr/share or /usr/local?
# Because /usr/local/share holds read-only, architecture-independent data for applications installed in /usr/local
# Which are basically documentation files or configuration files for a locally compiled/installed program
sudo mv doc/generated/* /usr/local/share/man


# optionally copy awww completion files
# sudo cp completions/awww.bash ~/.local/share/bash-completion/completions/awww.bash
# sudo cp completions/_awww ~/.local/share/zsh/site-functions/_awww.zsh
# sudo cp completions/awww.fish ~/.local/share/fish/vendor_completions.d/awww.fish

# For CachyOS vendor completions for fish
sudo cp completions/awww.fish /usr/share/fish/vendor_completions.d/awww.fish

# Creation of symlinks for waypaper in case it somehow only recognizes swww (awww's old name) and not awww
sudo ln -s /usr/bin/awww-daemon /usr/bin/swww-daemon
sudo ln -s /usr/bin/awww /usr/bin/swww

# Install waypaper
sudo pacman -S waypaper

# Install hyprpaper
sudo pacman -S hyprpaper

# Install uv
# Either:
# sudo pacman -S uv
# or
curl -LsSf https://astral.sh/uv/install.sh | sh

# Then optionally add shell completion for uv commands and uvx for fish
# echo 'uv generate-shell-completion fish | source' > ~/.config/fish/completions/uv.fish
# echo 'uvx --generate-shell-completion fish | source' > ~/.config/fish/completions/uvx.fish
# For CachyOS specifically (which uses /usr/share/fish/completions)
# echo 'uv generate-shell-completion fish | source' > /usr/share/fish/completions/uv.fish
# echo 'uvx --generate-shell-completion fish | source' > /usr/share/fish/completions/uvx.fish

# Install Stirling PDF
# Reference: https://docs.stirlingpdf.com/Installation/Unix%20Installation/
sudo pacman -S git automake autoconf libtool \
    leptonica pkg-config make gcc \
    jdk21-openjdk

# Notes:
# leptonica is libleptonica-dev for CachyOS
# zlib-ng-compat *might* count as zlib1g-dev for CachyOS
# jdk21-openjdk is openjdk-21-jdk for CachyOS
# Installing python on Arch/CachyOS *might* install both python3 and python3-pip

# Clone and Build jbig2enc (Only required for certain OCR functionality)
mkdir ~/.git
cd ~/.git &&\
git clone https://github.com/agl/jbig2enc.git &&\
cd jbig2enc &&\
./autogen.sh &&\
./configure &&\
make &&\
sudo make install

# Install Additional Software
# LibreOffice for conversions, tesseract for OCR, and opencv for pattern recognition functionality
# Also include OCR Language Support for English and Filipino
sudo pacman -Syu libreoffice-fresh tesseract tesseract-data-eng tesseract-data-fil
uv pip install uno opencv-python-headless unoserver pngquant WeasyPrint

# Notes:
# libreoffice-fresh-xx installs Libre Office with the latest features
# while libreoffice-still-xx installs the most stable version of Libre Office
# either of the two options install the *entire* Libre Office suite including:
# LibreOffice Writer, LibreOffice Calc, LibreOffice Impress, LibreOffice Draw, LibreOffice Base, and LibreOffice Math

# Install
sudo wget https://files.stirlingpdf.com/Stirling-PDF-with-login.jar
sudo chmod +x Stirling-PDF-with-login.jar

# Install GitHub repository Stirling PDF
cd ~/.git
git clone https://github.com/Stirling-Tools/Stirling-PDF.git
cd Stirling-PDF
sudo mv scripts /opt/Stirling-PDF

# Add a Desktop Icon (Bash)
# location=$(pwd)/gradlew
# image=$(pwd)/docs/stirling-transparent.svg

# cat > ~/.local/share/applications/Stirling-PDF.desktop <<EOF
# [Desktop Entry]
# Name=Stirling PDF;
# GenericName=Launch StirlingPDF and open its WebGUI;
# Category=Office;
# Exec=xdg-open http://localhost:8080 && nohup $location java -jar /opt/Stirling-PDF/Stirling-PDF-*.jar &;
# Icon=$image;
# Keywords=pdf;
# Type=Application;
# NoDisplay=false;
# Terminal=true;
# EOF

# Fish equivalent script
set location "$PWD/gradlew"
set image "$PWD/docs/stirling-transparent.svg"

printf '[Desktop Entry]
Name=Stirling PDF
GenericName=Launch StirlingPDF and open its WebGUI
Category=Office
Exec=sh -c "xdg-open http://localhost:8080 && nohup %s java -jar /opt/Stirling-PDF/Stirling-PDF-*.jar &"
Icon=%s
Keywords=pdf;
Type=Application
NoDisplay=false
Terminal=true' "$location" "$image" > ~/.local/share/applications/Stirling-PDF.desktop

# Download devtui
# The format to download a latest release file from a repository is the following:
# curl -L https://github.com/<owner>/<repository>/releases/latest/download/<asset_name> -O
curl -L https://github.com/skatkov/devtui/releases/latest/download/devtui_Linux_x86_64.tar.gz  -O

# Extract devtui
tar -xvf devtui_Linux_x86_64.tar.gz
rm devtui_Linux_x86_64.tar.gz LICENSE README.md # optionally include the LICENSE file and README.md

# Move devtui to /usr/local/bin
sudo mv devtui /usr/local/bin

# Install skim
sudo pacman -S skim # or cargo install skim

# For fish, add to ~/.config/fish/completions/
# sk --shell fish > ~/.config/fish/completions/sk.fish

# Specifically for CachyOS, use sudo tee because writing to /usr/share requires root privileges
sk --shell fish | sudo tee /usr/share/fish/completions/sk.fish
