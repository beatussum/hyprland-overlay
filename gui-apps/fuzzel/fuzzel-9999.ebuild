# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fuzzel.git"
else
	SRC_URI="https://codeberg.org/dnkl/fuzzel/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

DESCRIPTION="Application launcher for wlroots based Wayland compositors"
HOMEPAGE="https://codeberg.org/dnkl/fuzzel/"
LICENSE="MIT"
SLOT="0"
IUSE="cairo +nanosvg +png +svg"

REQUIRED_USE="
	nanosvg? ( svg )
	!nanosvg? ( svg? ( cairo ) )
"

RESTRICT="test"

DEPEND="
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libffi:=
	dev-libs/libpcre2:=
	dev-libs/libutf8proc:=
	dev-libs/wayland
	media-gfx/graphite2
	>=media-libs/fcft-3.0.0
	<media-libs/fcft-4.0.0
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz:=
	media-libs/libpng:=
	sys-libs/zlib:=
	x11-libs/libxkbcommon
	x11-libs/pixman

	cairo? (
		x11-libs/cairo
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libxkbcommon
		x11-libs/libXrender
	)

	png? ( media-libs/libpng:= )

	svg? (
		!nanosvg? (
			dev-libs/fribidi
			dev-libs/icu:=
			dev-libs/libxml2:2
			media-libs/libjpeg-turbo:=
			gnome-base/librsvg:2
			x11-libs/gdk-pixbuf:2
			x11-libs/pango
		)
	)
"

BDEPEND="
	app-text/scdoc
	>=dev-build/meson-0.58.0
	>=dev-libs/tllist-1.0.1
	>=dev-libs/wayland-protocols-1.32
	dev-util/wayland-scanner
"

RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i \
		"/get_option('datadir'), 'doc', 'fuzzel'/ s/fuzzel/${PF}/" \
		meson.build \
		|| die
}

src_configure() {
	local svg_backend

	if use svg; then
		if use nanosvg; then
			svg_backend="nanosvg"
		else
			svg_backend="librsvg"
		fi
	else
		svg_backend="none"
	fi

	local emesonargs=(
		$(meson_feature cairo enable-cairo)
		-Dpng-backend=$(usex png libpng none)
		-Dsvg-backend=${svg_backend}
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	rm -f "${ED}/usr/share/doc/${PF}/LICENSE" || die
}
