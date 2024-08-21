# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font git-r3

DESCRIPTION="Readex Pro is the world-script expansion of Lexend"
HOMEPAGE="http://www.lexend.com/"
EGIT_REPO_URI="https://github.com/ThomasJockin/readexpro.git"
LICENSE="OFL-1.1"
SLOT="0"

DOCS=(
	AUTHORS.txt
	CONTRIBUTORS.txt
	README.md
)

FONT_SUFFIX="ttf"
FONT_S=( "${S}/fonts"/{ttf,variable} )
