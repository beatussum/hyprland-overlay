# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Opensource, compact, and material-designed cursor set"
HOMEPAGE="https://www.bibata.live/"
SRC_URI="https://github.com/ful1e5/Bibata_Cursor/releases/download/v${PV}/Bibata.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="binchecks strip test"

RDEPEND="x11-libs/libXcursor"

src_install() {
	insinto /usr/share/icons

	for cursor in Bibata-*; do
		doins -r "${cursor}"

		dosym -r \
			"/usr/share/icons/${cursor}" \
			"/usr/share/cursors/xorg-x11/${cursor}"
	done
}
