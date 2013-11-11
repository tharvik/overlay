# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 cmake-utils

DESCRIPTION="A portable, open-source, coherent noise-generating library for C++"
HOMEPAGE="http://libnoise.sourceforge.net/"
EGIT_REPO_URI=${EGIT_REPO_URI:-"https://github.com/qknight/libnoise.git"}
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
	dosym /usr/include/noise /usr/include/libnoise
}
