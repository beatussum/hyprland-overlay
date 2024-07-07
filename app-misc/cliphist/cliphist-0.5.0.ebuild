# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Wayland clipboard manager with support for multimedia"
HOMEPAGE="https://github.com/sentriz/cliphist"
SRC_URI="https://github.com/henri-gasc/cliphist/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="BSD GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	gui-apps/wl-clipboard
	x11-misc/xdg-utils
"

RDEPEND="${DEPEND}"

DOCS=(
	CHANGELOG.md
	readme.md
)

src_compile() {
	ego build
}

src_test() {
	ego test
}

src_install() {
	einstalldocs

	dobin "${PN}"
}
