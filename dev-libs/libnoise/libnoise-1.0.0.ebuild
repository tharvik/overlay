# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A portable, open-source, coherent noise-generating library for C++"
HOMEPAGE="http://libnoise.sourceforge.net/"
SRC_URI="http://prdownloads.sourceforge.net/libnoise/libnoisesrc-1.0.0.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/local/{include/noise,lib}
	cp -r include "${D}/usr/local/include/noise"
	cp -r lib/* "${D}/usr/local/lib"
	dosym /usr/local/lib/libnoise.so{.0,}
}
