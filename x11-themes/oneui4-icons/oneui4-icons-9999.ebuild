# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg

DESCRIPTION="One UI Icons for Linux"
HOMEPAGE="https://github.com/mjkim0727/OneUI4-Icons"
EGIT_REPO_URI="https://github.com/mjkim0727/OneUI4-Icons.git"
LICENSE="GPL-3+"
SLOT="0"

DOCS=(
	preview/
	screenshots/
	logo.png
	README.md
)

src_install() {
	einstalldocs

	insinto /usr/share/icons
	doins -r OneUI{,-dark,-light}
}
