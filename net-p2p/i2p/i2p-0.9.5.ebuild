# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="I2P is an anonymizing network, offering a simple layer that identity-sensitive applications can use to securely communicate"
HOMEPAGE="https://www.i2p2.de/"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~amd64"
IUSE="doc jetty geoip" #!

SRC_URI="http://mirror.i2p2.de/i2psource_${PV}.tar.bz2"

DEPEND=">=virtual/jdk-1.6.0
		>=app-arch/unzip-6.0-r3"
RDEPEND=">=virtual/jre-1.6.0"

EANT_BUILD_TARGET="tarball"

src_configure() {
	cd "${S}"
	sed 's/#noExe=true/noExe=true/' build.properties
}

src_install() {
	mkdir -p "${D}"/opt/i2p || die
	cd "${S}"
	mv i2p.tar.bz2 "${D}"/opt/i2p || die
	cd "${D}"/opt/i2p || die
	tar xjvf i2p.tar.bz2 || die
}

