# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="The Scala IDE bundle to run eclipse with tools for scala"
HOMEPAGE="http://scala-ide.org"
SRC_URI="http://downloads.typesafe.com/scalaide-pack/3.0.1.vfinal-210-20130718/scala-SDK-3.0.1-vfinal-2.10-linux.gtk.x86_64.tar.gz"

LICENSE="Scala"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/jre"
RDEPEND="${DEPEND}"

src_install() {

	dodir /usr/{bin,share/"${P}"}
	cp "${S}"/* "${D}"/usr/share/"${P}"
	dosym /usr/share/"${P}"/eclipse /usr/bin/eclipse
}
