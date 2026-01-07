#!/usr/bin/env bash
# Building from the ground up for Fedora

# Some dependencies:
sudo dnf install cmake # needed for make

# pugixml (hyprwayland-scanner depends on this), use .i686 if using a different architecture
sudo dnf install pugixml-devel # you need devel files for compiling things from source (you can't use the ones without devel, which are just binaries)

# hyprwayland-scanner (Aquamarine depends on this)
git clone --recursive https://github.com/hyprwm/hyprwayland-scanner.git
cd hyprwayland-scanner
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
sudo cmake --install build

# hyprutils (Aquamarine depends on this)
git clone https://github.com/hyprwm/hyprutils.git
cd hyprutils/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# other dnf installations that may be needed by aquamarine
sudo dnf install libseat-devel \
libinput-devel \
wayland-protocols-devel.noarch \
libdrm-devel \
mesa-libgbm-devel \
libdisplay-info-devel \
hwdata-devel.noarch

# Aquamarine (Hyprland depends on this)
git clone --recursive https://github.com/hyprwm/aquamarine.git
cd aquamarine
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build

# hyprlang (Hyprland depends on this)
git clone --recursive https://github.com/hyprwm/hyprlang.git
cd hyprlang
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build

# dnf installations that may be needed by hyprcursor
sudo dnf install cairo-devel \
libzip-devel \
librsvg2-devel \
tomlplusplus-devel

# hyprcursor (Hyprland depends on this)
git clone --recursive https://github.com/hyprwm/hyprcursor.git
cd hyprcursor
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build

# dnf installations that may be needed by hyprgraphics
sudo dnf install pixman-devel \
libjpeg-turbo-devel \
libwebp-devel \
libjxl-devel \
file-devel \
libpng-devel

# Notes:
# libjxl-devel is optional
# file-devel contains/is libmagic

# hyprgraphics (Hyprland depends on this)
git clone https://github.com/hyprwm/hyprgraphics
cd hyprgraphics/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# dnf installations that may be needed by Hyprland
sudo dnf install libuuid-devel \
re2-devel \
muParser-devel \
xcb-util-errors-devel \
xcb-util-wm-devel

# Notes:
# use libuuid-devel for installing development files for uuid, not uuid-devel
# do not use libxcb-devel for xcb-icccm and xcb-errors
# use xcb-util-errors-devel for xcb-errors
# use xcb-util-wm-devel for xcb-icccm

# hyprwire (Hyprland depends on this)
git clone --recursive https://github.com/hyprwm/hyprwire.git
cd hyprwire
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# Hyprland (the very thing I need to install)
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install

# Post-install (optional stuff for Hyprland dependencies as well as Hyprland ecosystem)

# dnf dependency for hyprtoolkit
sudo dnf install iniparser-devel

# hyprtoolkit (a dependency of many Hyprland ecosystem packages)
git clone --recursive https://github.com/hyprwm/hyprtoolkit.git
cd hyprtoolkit
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# hyprshutdown
git clone --recursive https://github.com/hyprwm/hyprshutdown.git
cd hyprshutdown
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# dnf dependencies for hyprlauncher
sudo dnf install libqalculate-devel

# hyprlauncher
git clone --recursive https://github.com/hyprwm/hyprlauncher.git
cd hyprlauncher
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# dependencies for walker
sudo dnf install gtk4-devel \
gtk4-layer-shell-devel \
poppler-glib-devel \
protobuf-compiler

# dependencies for elephant
sudo dnf install golang-bin # Go compiler (gc)

# assuming you have not added go, set GOPATH and GOBIN
go env -w GOPATH=$HOME/go
go env -w GOBIN=$HOME/go/bin

# and add/append GOPATH and GOBIN to PATH in .bashrc (or .zshrc)
printf "export GOPATH=\"$HOME/go\"\nexport GOBIN=\"$GOPATH/bin\"\nexport PATH=\"$PATH:$GOBIN\"" >> ~/.bashrc

# elephant (walker needs this)
git clone https://github.com/abenz1267/elephant
cd elephant

# Build and install the main binary
cd cmd/elephant
go install elephant.go

# Create configuration directories
mkdir -p ~/.config/elephant/providers

# Build and install a provider (example: desktop applications)
cd ../../internal/providers/desktopapplications
go build -buildmode=plugin
cp desktopapplications.so ~/.config/elephant/providers/

# bookmarks provider
cd ../bookmarks
go build -buildmode=plugin
cp bookmarks.so ~/.config/elephant/providers/

# bluetooth provider
cd ../bluetooth
go build -buildmode=plugin
cp bluetooth.so ~/.config/elephant/providers/

# calculator provider
cd ../calc
go build -buildmode=plugin
cp calc.so ~/.config/elephant/providers/

# clipboard provider
cd ../clipboard
go build -buildmode=plugin
cp clipboard.so ~/.config/elephant/providers/

# files provider
cd ../files
go build -buildmode=plugin
cp files.so ~/.config/elephant/providers/

# menus provider
cd ../menus
go build -buildmode=plugin
cp menus.so ~/.config/elephant/providers/

# providerlist provider
cd ../providerlist
go build -buildmode=plugin
cp providerlist.so ~/.config/elephant/providers/

# runner provider
cd ../runner
go build -buildmode=plugin
cp runner.so ~/.config/elephant/providers/

# snippets provider
cd ../snippets
go build -buildmode=plugin
cp snippets.so ~/.config/elephant/providers/

# symbols provider
cd ../symbols
go build -buildmode=plugin
cp symbols.so ~/.config/elephant/providers/

# todo provider
cd ../todo
go build -buildmode=plugin
cp todo.so ~/.config/elephant/providers/

# unicode provider
cd ../unicode
go build -buildmode=plugin
cp unicode.so ~/.config/elephant/providers/

# websearch provider
cd ../websearch
go build -buildmode=plugin
cp websearch.so ~/.config/elephant/providers/

# windows provider
cd ../windows
go build -buildmode=plugin
cp windows.so ~/.config/elephant/providers/

# custom clipvault provider (requires clipvault, not provided in official repositories)
cd ../clipvault
go build -buildmode=plugin
cp clipvault.so ~/.config/elephant/providers/

# enable elephant as a service
elephant service enable

# walker (hyprlauncher alternative)
git clone https://github.com/abenz1267/walker.git
cd walker

# Build with Cargo
cargo build --release

# Run Walker
# ./target/release/walker

# or install it system-wide
sudo cp target/release/walker /usr/bin

# dnf dependencies for hyprqt6engine
sudo dnf install qt6-qtbase-devel \
qt6-qtdeclarative-devel \
qt6-qttools-devel \
qt6-qtgraphs-devel \
qt6-qtmultimedia-devel \
qt6-qtsvg-devel \
qt6-qtbase-private-devel

# Note: All of the packages above comprise the tools needed for qt6ct

# hyprqt6engine
git clone --recursive https://github.com/hyprwm/hyprqt6engine.git
cd hyprqt6engine
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# dnf dependencies for hyprpwcenter
sudo dnf install pipewire-libs

# hyprpwcenter
git clone --recursive https://github.com/hyprwm/hyprpwcenter.git
cd hyprpwcenter
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# hyprland-guiutils
git clone --recursive https://github.com/hyprwm/hyprland-guiutils.git
cd hyprland-guiutils
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# dependencies for hyprsunset
git clone https://github.com/hyprwm/hyprland-protocols && cd hyprland-protocols
cmake -S . -B ./build
cmake --build ./build

# also do this for hyprland-protocols
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# hyprsunset
git clone --recursive https://github.com/hyprwm/hyprsunset.git
cd hyprsunset
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# sunsetr (hyprsunset, but automatically switches blue-light filter)
git clone https://github.com/psi4j/sunsetr.git &&
cd sunsetr

# Build with cargo
cargo build --release

# Then install manually
sudo cp target/release/sunsetr /usr/local/bin/

# hyprland-qt-support
git clone --recursive https://github.com/hyprwm/hyprland-qt-support.git
cd hyprland-qt-support
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# xdg-desktop-portal-hyprland
git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland
cd xdg-desktop-portal-hyprland/
cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
sudo cmake --install build

# dnf dependencies for hyprpolkitagent
sudo dnf install polkit-devel \
polkit-qt6-1-devel

# Notes
# polkit-devel is polkit-agent-1
# polkit-qt6-1-devel is polkit-qt6-1

# hyprpolkitagent
git clone --recursive https://github.com/hyprwm/hyprpolkitagent.git
cd hyprpolkitagent
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# hyprsysteminfo
git clone --recursive https://github.com/hyprwm/hyprsysteminfo.git
cd hyprsysteminfo
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# hyprpaper
git clone --recursive https://github.com/hyprwm/hyprpaper.git
cd hyprpaper
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build

# hyprpicker
git clone --recursive https://github.com/hyprwm/hyprpicker.git
cd hyprpicker
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# dnf dependencies for hyprlock
sudo dnf install sdbus-cpp-devel

# hyprlock
git clone --recursive https://github.com/hyprwm/hyprlock.git
cd hyprlock
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build

# dependencies for hyprshot
sudo dnf install slurp grim

# hyprshot (screenshot utility)
git clone https://github.com/Gustash/hyprshot.git Hyprshot
ln -s $(pwd)/Hyprshot/hyprshot $HOME/.local/bin
chmod +x Hyprshot/hyprshot

# hypridle (idle screen saver)
git clone https://github.com/hyprwm/hypridle.git
cd hypridle
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

# waybar (status bar)
sudo dnf install waybar

# ashell (also a status bar, alternative to waybar)
git clone https://github.com/MalpenZibo/ashell.git
cd ashell
cargo build --release

# To install it system-wide
sudo cp target/release/ashell /usr/bin

# Install meson, a build system used by SwayOSD
sudo dnf install meson

# Dependencies for SwayOSD (if compiling from source)
sudo dnf install sassc

# dnf dependencies for eww
sudo dnf install libdbusmenu-devel \
libdbusmenu-gtk3-devel \
gtk-layer-shell-devel

# eww (Rust-based widget system, alternative to Quickshell)
echo "Creating temporary working directory for eww..."
rm -rf /tmp/eww
mkdir /tmp/eww
cd /tmp/eww
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features=wayland
cd target/release
chmod +x ./eww
sudo cp eww /usr/bin
# To open eww
# ./eww daemon
# ./eww open <window_name>

# SwayOSD (OSD for Hyprland)

# Use this below if downloading from cargo
# sudo dnf copr enable erikreider/swayosd
# sudo dnf install swayosd

# Use this if building from source
git clone --recursive https://github.com/ErikReider/SwayOSD.git
cd SwayOSD
meson setup build --buildtype release
ninja -C build
meson install -C build

# Used for notifying when caps-lock, scroll-lock, and num-lock is changed.
sudo systemctl enable --now swayosd-libinput-backend.service

# clipvault (cliphist-inspired clipboard manager)
cargo install clipvault --locked

# dnf dependencies for awww
sudo dnf install lz4-devel

# awww (Wayland Wallpaper Manager, formerly named swww)
git clone https://codeberg.org/LGFae/awww.git
cd awww
cargo build --release
sudo cp target/release/awww /usr/bin
sudo cp target/release/awww-daemon /usr/bin

# optionally copy awww completion files
sudo cp completions/awww.bash ~/.local/share/bash-completion/completions/awww.bash
sudo cp target/release/_awww ~/.local/share/zsh/site-functions/_awww.zsh
sudo cp target/release/awww.fish ~/.local/share/fish/vendor_completions.d/awww.fish

# waypaper (frontend for awww and hyprpaper)
sudo dnf copr enable solopasha/hyprland
sudo dnf install waypaper

# fastfetch (system display)
sudo dnf install fastfetch

# dnf dependencies for wleave
sudo dnf install libadwaita-devel

# wleave (Wayland logout prompt utility based from wlogout, written in Rust)
git clone https://github.com/AMNatty/wleave.git
cd wleave
cargo build --release
sudo cp target/release/wleave /usr/bin

# tweaks from Hyprland

# from https://wiki.hypr.land/Nvidia/
sudo dnf install egl-wayland2

# hyprland.conf necessities

sudo dnf install brightnessctl # for brightness/backlight adjustment
sudo dnf install nm-applet # used for Wi-Fi pop-up dialogs
sudo dnf install gnome-keyring # needed as a keyring for nm-applet and NetworkManager on non-GNOME/non-KDE environments

# waybar necessities
sudo dnf install pavucontrol # used to control audio
git clone https://github.com/bjesus/wttrbar.git
cd wttrbar
cargo build --release
sudo cp target/release/wttrbar /usr/bin

# command-line stuff
cargo install eza bat # Rust alternatives for ls and cat respectively
sudo dnf install fd-find # Rust alternative for find

sudo dnf install zsh # Zsh shell
sudo dnf install fish # Fish shell
