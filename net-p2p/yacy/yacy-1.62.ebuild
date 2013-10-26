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

EANT_BUILD_TARGET="copyMain4Dist"

src_unpack() {
	default
	mv "${WORKDIR}/yacy" "${S}" || die "Unable to rename downloaded archive"
}

src_configure() {
	default

	# patch to have the pidfile for rc-service
	epatch "${FILESDIR}/${P}-rc-service-pid.patch"
}

src_install() {
	default

	insopts -o yacy -g yacy
	dodir "/usr/share/${P}" &&
	chmod +x "${S}/RELEASE/MAIN/"{,bin/,addon/}*.sh &&
	mv "${S}/RELEASE/MAIN/"* "${D}/usr/share/${P}" ||
		die "Unable to move compiled files to temporary install directory"

	# add rc-service
	newinitd "${FILESDIR}/${P}-rc-service" "yacy" || die "Unable to install the rc-service"
}

pkg_postinst() {

	# add user and group for rc-service
	enewgroup yacy
	enewuser yacy -1 -1 -1 yacy
}
