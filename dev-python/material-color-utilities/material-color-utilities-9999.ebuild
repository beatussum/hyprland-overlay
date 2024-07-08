# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{4..12} )

inherit distutils-r1

DESCRIPTION="Python port of material-color-utilities used for Material You colors"
HOMEPAGE="https://github.com/avanisubbiah/material-color-utilities-python/"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/avanishsubbiah/material-color-utilities-python.git"
else
	PYPI_NO_NORMALIZE=true
	PYPI_PN="${PN}-python"

	inherit pypi

	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="binchecks strip test"

RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
"
