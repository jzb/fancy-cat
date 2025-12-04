#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 -y copr enable avengemedia/dms

# Add Vivaldi repo

tee /etc/yum.repos.d/vivaldi.repo <<'EOF'
[vivaldi]
name=vivaldi
baseurl=https://repo.vivaldi.com/archive/rpm/x86_64
enabled=1
gpgcheck=1
gpgkey=https://repo.vivaldi.com/archive/linux_signing_key.pub
EOF

PACKAGES=(
	bat
	claws-mail
	claws-mail-plugins
	cosmic-term
	dms
	emacs
	emacs-common
	emacsclient
	emacs-filesystem
	fuzzel
	lolcat
	niri
	okular
	pandoc-pdf
	virt-manager
	virt-manager-common
	tmux
	vivaldi-stable
	waypipe
	wdisplays
	yt-dlp
)

UNINSTALL_PACKAGES=(
	waydroid
	waydroid-selinux
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
