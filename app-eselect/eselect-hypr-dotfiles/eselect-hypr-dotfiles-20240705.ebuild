# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A customizable and extensible shell"
HOMEPAGE="https://github.com/beatussum/eselect-hypr-dotfiles/"
SRC_URI="https://github.com/beatussum/eselect-hypr-dotfiles/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="binchecks strip !test? ( test )"

DEPEND="app-admin/eselect"
BDEPEND="test? ( >=dev-util/shellspec-0.28.1 )"
RDEPEND="${DEPEND}"

DOCS=(
	ChangeLog
	CODE_OF_CONDUCT.md
	CONTRIBUTING.md
	copyright
	README.md
	SECURITY.md
)

src_install() {
	einstalldocs

	emake DESTDIR="${ED}" PREFIX="${ED}/usr" install
}
