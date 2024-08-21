# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font git-r3

DESCRIPTION="A five weight Roman and Italic family"
HOMEPAGE="https://github.com/googlefonts/rubik/"
EGIT_REPO_URI="https://github.com/googlefonts/rubik.git"
LICENSE="OFL-1.1"
SLOT="0"

DOCS=(
	AUTHORS.txt
	CONTRIBUTORS.txt
	README.md
)

FONT_SUFFIX="ttf"
FONT_S="${S}/fonts/variable"
