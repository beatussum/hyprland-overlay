# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="A program to read and control device brightness"
HOMEPAGE="https://github.com/Hummer12007/brightnessctl/"
SRC_URI="https://github.com/Hummer12007/brightnessctl/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd udev"

DEPEND="
	systemd? ( sys-apps/systemd )
	udev? ( virtual/udev )
"

BDEPEND="systemd? ( virtual/pkgconfig )"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i "/INSTALL_UDEV_RULES=0/d" Makefile \
		|| die 'Cannot prevent conflict between `systemd` and `udev`'
}

src_compile() {
	emake "$(usex systemd "ENABLE_SYSTEMD=1" "")"
}

src_install() {
	einstalldocs
	emake INSTALL_UDEV_RULES="$(usex udev 1 0)" DESTDIR="${ED}" install
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
