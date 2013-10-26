# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit java-pkg-2 java-ant-2

DESCRIPTION=" YaCy is a distributed search engine."
HOMEPAGE="http://yacy.net"
SRC_URI="http://yacy.net/release/yacy_v1.62_20130801_9025.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/jdk:1.6"
RDEPEND="${DEPEND}
		dev-java/ant-core"

EANT_BUILD_TARGET="dist"
TAR_SUFFIX="_20131025_9000"

src_unpack() {
	default_src_unpack
	mv "${WORKDIR}/yacy" "${S}" || die "Unable to rename downloaded archive"
}

#src_compile() {
#	ANT_TASKS="dist" eant package || die "Unable to compile"
#}

src_install() {
	dodir "/usr/share/${P}" "/usr/bin"
	insinto "/usr/share/${P}"
	cd "${T}"
	tar xvf "${S}/RELEASE/yacy_v${PV}${TAR_SUFFIX}.tar.gz" || die "Unable to unpack compiled archive"
	mv "${T}/yacy/"* "${D}/usr/share/${P}" || die "Unable to move compiled files to temporary install directory"
	dosym "/usr/share/${P}/startYACY.sh" "/usr/bin/yacy-start"
	dosym "/usr/share/${P}/stopYACY.sh" "/usr/bin/yacy-stop" 
}
