# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="C/C++ library to add light and intuitive GUI to OpenGL and DX programs"
HOMEPAGE="http://anttweakbar.sourceforge.net/doc/"
SRC_URI="mirror://sourceforge/anttweakbar/${PN}_${PV}.zip"

LICENSE="zlib"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	cd "${S}/src"
	emake
}

src_install() {
	dolib.so "lib/lib${PN}.so"
	dolib.so "lib/lib${PN}.so.1"

	insinto "/usr/include"
	doins "include/${PN}.h"
}
