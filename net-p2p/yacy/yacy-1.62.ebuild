# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit java-pkg-2 java-ant-2

DESCRIPTION=" YaCy is a distributed search engine."
HOMEPAGE="http://yacy.net"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/jdk:1.6"
RDEPEND="${DEPEND}
		dev-java/ant-core"

src_install() {
	dodir "/usr/share/${P}"
	unpack "${S}/yacy/RELEASE/yacy_v${PV}*.tar.gz" || die "Unable to unpack compiled archive"
	cp "${S}/yacy/*" "${D}/usr/share/${P}/"
}
