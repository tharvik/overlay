# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="C/C++ library to add light and intuitive GUI to OpenGL and DX programs"
HOMEPAGE="http://anttweakbar.sourceforge.net/doc/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="zlib"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}/src"
	emake
}

src_install() {
	die
}
