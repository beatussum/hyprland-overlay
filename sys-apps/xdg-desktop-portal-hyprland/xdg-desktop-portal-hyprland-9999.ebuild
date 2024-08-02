# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="xdg-desktop-portal backend for hyprland"
HOMEPAGE="https://wiki.hyprland.org/Useful-Utilities/xdg-desktop-portal-hyprland/"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland.git"
else
	SRC_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="test"

DEPEND="
	app-arch/zstd:=
	app-crypt/libb2
	dev-cpp/sdbus-c++:=
	dev-libs/double-conversion
	dev-libs/expat
	dev-libs/glib:2
	>=dev-libs/hyprlang-0.2.0
	dev-libs/icu:=
	dev-libs/libffi:=
	dev-libs/libpcre2:=
	dev-libs/wayland
	dev-qt/qtbase:6[widgets]
	media-gfx/graphite2
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz:=
	media-libs/libglvnd
	media-libs/libpng:=
	media-libs/mesa
	>=media-video/pipewire-1.1.82:=
	sys-apps/dbus
	sys-libs/libcap
	sys-libs/zlib:=
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb:=
	x11-libs/libXdmcp
"

BDEPEND="
	>=dev-build/cmake-3.19
	>=dev-libs/wayland-protocols-1.31
	dev-util/wayland-scanner
	virtual/pkgconfig
"

RDEPEND="
	sys-apps/xdg-desktop-portal
	${DEPEND}
"

DOCS=(
	CONTRIBUTING.md
	README.md
	VERSION
)

src_prepare() {
	cmake_src_prepare
	sed -i "/add_compile_options(-O3)/d" CMakeLists.txt || die
}
