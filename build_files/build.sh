#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 -y copr enable avengemedia/dms

PACKAGES=(
	aerc
	bat
	dms
	emacs
	emacs-common
	emacsclient
	emacs-filesystem
	fuzzel
	gnome-keyring
	kid3
	konsole
	lolcat
	nautilus
	niri
	okular
	soundkonverter
	tmux
	waybar
	waypipe
	wdisplays
	xdg-desktop-portal-gnome
	xdg-desktop-portal-gtk
	xfce-polkit
	yt-dlp
)

UNINSTALL_PACKAGES=( 
	waydroid
	waydroid-selinux
	lutris
	amd-gpu-firmware
	amd-ucode-firmware
	antiword
	braille-printer-app
)

# this installs packages from the Fedora repositories

dnf5 install -y --allowerasing "${PACKAGES[@]}"

dnf5 remove -y "${UNINSTALL_PACKAGES[@]}"

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
