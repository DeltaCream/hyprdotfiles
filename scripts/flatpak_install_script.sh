#!/usr/bin/env bash

set -euo pipefail

# Colors (optional)
BLUE='\e[34m'
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m" # No color

echo -e "${BLUE}=== Flatpak Install Script ===${NC}"

# -----------------------------
# 1. Ensure flatpak is installed
# -----------------------------

if ! command -v flatpak >/dev/null 2>&1; then
    echo -e "${RED}Flatpak is not installed. Please install it first.${NC}"
    exit 1
fi

# -----------------------------
# 2. Add Flathub if missing
# -----------------------------
if ! flatpak remote-list | grep -q flathub; then
    echo "Adding Flathub remote…"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# -----------------------------
# 3. Install flatpak apps
# -----------------------------

# List of apps to install
FLATPAK_APPS=(
    # very first ones, example by ChatGPT
    # org.mozilla.firefox
    com.spotify.Client
    # org.onlyoffice.desktopeditors
    me.iepure.devtoolbox
    io.gitlab.liferooter.TextPieces

    # --- Gaming ---
    com.usebottles.bottles
    page.kramo.Cartridges
    net.davidotek.pupgui2
    com.vysp3r.ProtonPlus
    org.libretro.RetroArch
    org.freedesktop.Piper
    xyz.z3ntu.razergenie
    com.heroicgameslauncher.hgl
    net.lutris.Lutris
    # com.valvesoftware.Steam
    # org.winehq.Wine
    io.github.fastrizwaan.WineZGUI
    io.github.fastrizwaan.WineCharm
    org.vinegarhq.Sober
    org.azahar_emu.Azahar # 3DS Emulator, continuation of Citra
    net.kuribo64.melonDS # Nintendo DS Emulator

    # --- Utilities ---
    app.zen_browser.zen
    org.mozilla.Thunderbird
    eu.betterbird.Betterbird
    net.ankiweb.Anki
    # org.blender.Blender
    re.sonny.Tangram
    # fr.romainvigier.MetadataCleaner (unmaintained)
    io.github.najepaliya.kleaner
    io.github.tobagin.scramble
    # org.kde.krita
    com.belmoussaoui.Decoder
    vn.hoabinh.quan.CoBang
    app.drey.Dialect
    io.github.amit9838.mousam
    com.belmoussaoui.Obfuscate # (doubles as security)
    de.schmidhuberj.DieBahn
    com.github.hugolabe.Wike
    info.febvre.Komikku
    # org.gimp.GIMP
    com.github.tenderowl.frog
    com.github.johnfactotum.Foliate # (doubles as text utility for reading)
    com.rustdesk.RustDesk
    io.github.denysmb.klaro
    org.kde.kweather
    org.kde.kalk
    org.kde.kclock
    org.audacityteam.Audacity

    # — Text Utilities ---
    com.logseq.Logseq
    md.obsidian.Obsidian
    de.leopoldluley.Clapgrep
    io.appflowy.AppFlowy
    org.qownnotes.QOwnNotes
    io.github.cgueret.Scriptorium

    # ---Suites ---
    org.onlyoffice.desktopeditors

    # ---Video Utilities ---
    de.schmidhuberj.tubefeeder
    org.kde.kdenlive
    com.obsproject.Studio
    org.kde.plasmatube
    # org.videolan.VLC

    # ---Music and Audio Utilities ---
    org.gnome.Lollypop
    io.github.seadve.Mousai
    de.haeckerfelix.Shortwave
    app.drey.EarTag
    de.haeckerfelix.AudioSharing
    org.ardour.Ardour

    # ---Image Utilities ---
    io.gitlab.adhami3310.Converter
    net.fasterland.converseen
    org.kde.digikam # open-source digital photo editor and manager
    org.upscayl.Upscayl # (doubles as AI)

    # ---Finance ---
    io.github.idevecore.Valuta
    org.kde.skrooge

    # ---Messaging ---
    org.telegram.desktop
    io.github.equicord.equibop
    io.github.spacingbat3.webcord

    # — System Administration ---
    net.nokyan.Resources
    io.missioncenter.MissionCenter

    # — System Customization ---
    org.gustavoperedo.FontDownloader
    org.gnome.font-viewer
    com.rafaelmardojai.WebfontKitGenerator
    io.github.getnf.embellish
    org.openrgb.OpenRGB
    page.tesk.Refine
    dev.edfloreshz.CosmicTweaks # (for COSMIC Desktop Environment)
    org.altlinux.Tuner
    io.github.realmazharhussain.GdmSettings

    # ---Security ---
    dev.geopjr.Collision
    io.wasabiwallet.WasabiWallet
    com.belmoussaoui.Authenticator
    org.kde.keysmith
    org.kde.kwalletmanager5
    com.bitwarden.desktop # (doubles as a password manager utility)
    com.quexten.Goldwarden # (doubles as a password manager utility)

    # ---Flatpak and Flathub Utilities ---
    io.github.flattool.Warehouse
    com.github.tchx84.Flatseal
    io.github.kolunmi.Bazaar

    # --- Programming ---
    com.vscodium.codium
    dev.zed.Zed
    dev.lapce.lapce
    com.visualstudio.code
    com.jetbrains.RustRover

    # --- Programming and Developer Utilities ---
    me.iepure.devtoolbox
    io.gitlab.liferooter.TextPieces
    com.github.huluti.Coulr

    # --- AI ---
    com.jeffser.Alpaca

    # --- Automation and Testing ---


    # — Virtualization and Emulation ---
    dev.boxi.Boxi
    io.github.dvlv.boxbuddyrs

    # — Torrent and File Sharing ---
    de.haeckerfelix.Fragments
    # org.qbittorrent.qBittorrent

    # — Education, Manuals, and Tutorials ---
    # org.kde.minuet

    # — Miscellaneous ---
    com.rafaelmardojai.Blanket
    dev.bragefuglseth.Keypunch
    io.github.roseblume.rosary
)

echo "Installing applications…"
for app in "${FLATPAK_APPS[@]}"; do
    echo "→ Installing $app"
    flatpak install -y flathub "$app"
done

echo -e "${GREEN}All Flatpak applications installed successfully!${NC}"
