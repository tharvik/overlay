# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="Tahoe-LAFS is a Free and Open cloud storage system"
HOMEPAGE="https://tahoe-lafs.org"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

SRC_URI="https://tahoe-lafs.org/source/tahoe-lafs/releases/allmydata-tahoe-1.9.2.zip"

DEPEND=">=dev-lang/python-2.5.4-r4"
#RDEPEND=">=virtual/jre-1.6.0"

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

