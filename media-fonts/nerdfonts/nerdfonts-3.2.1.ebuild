# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs font readme.gentoo-r1

FONTS=(
	0xProto
	3270
	Agave
	AnonymousPro
	Arimo
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CascadiaCode
	CascadiaMono
	CodeNewRoman
	ComicShannsMono
	CommitMono
	Cousine
	D2Coding
	DaddyTimeMono
	DejaVuSansMono
	DroidSansMono
	EnvyCodeR
	FantasqueSansMono
	FiraCode
	FiraMono
	GeistMono
	Gohu
	Go-Mono
	Hack
	Hasklig
	HeavyData
	Hermit
	iA-Writer
	IBMPlexMono
	Inconsolata
	InconsolataGo
	InconsolataLGC
	IntelOneMono
	Iosevka
	IosevkaTerm
	IosevkaTermSlab
	JetBrainsMono
	Lekton
	LiberationMono
	Lilex
	MartianMono
	Meslo
	Monaspace
	Monofur
	Monoid
	Mononoki
	MPlus
	NerdFontsSymbolsOnly
	Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	Recursive
	RobotoMono
	ShareTechMono
	SourceCodePro
	SpaceMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	UbuntuSans
	VictorMono
	ZedMono
)

FONT_URI_BASE="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}"

CHECKREQS_DISK_BUILD="8G"
CHECKREQS_DISK_USR="8G"

for font in "${FONTS[@]}"; do
	FONT_URIS+=( "${FONT_URI_BASE}/${font}.tar.xz -> ${PN}-${font}-${PV}.tar.xz" )
done

DESCRIPTION="Popular programming fonts with the addition of a bunch of glyphs"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts/"
SRC_URI="${FONT_URIS[*]}"

LICENSE="
	Apache-2.0
	BitstreamVera
	CC-BY-4.0
	CC-BY-SA-4.0
	MIT
	OFL-1.1
	UbuntuFontLicense-1.0
	WTFPL-2
"

SLOT="0"
KEYWORDS="~amd64"

FONT_SUFFIX="?tf"
FONT_S=( "${FONTS[@]/#/"${S}/"}" )

DOC_CONTENTS="
${CATEGORY}/${PN} installs a lot of files and, therefore, needs a large
diskspace.

If you want only some fonts and prevent installing others, it is possible to
filter them by using \`INSTALL_MASK\`, /etc/portage/env/ and
/etc/portage/package.env.

For more information, please see \`man 5 make.conf\` and \`man 5 portage\`.
"

pkg_setup() {
	check-reqs_pkg_setup
	font_pkg_setup
}

src_unpack() {
	for font in "${FONTS[@]}"; do
		mkdir "${font}" || die

		pushd "${font}" &>> /dev/null || die
		unpack "${PN}-${font}-${PV}.tar.xz"
		popd &>> /dev/null || die
	done
}

src_install() {
	font_src_install

	for font in "${FONTS[@]}"; do
		local readme="${S}/${font}/README.md"

		[[ -e "${readme}" ]] && newdoc "${readme}" "README.${font}.md"
	done

	readme.gentoo_create_doc
}

pkg_postinst() {
	font_pkg_postinst
	readme.gentoo_print_elog
}
