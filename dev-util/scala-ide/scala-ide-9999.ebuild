# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="The Scala IDE to build eclipse with tools for scala"
HOMEPAGE="http://scala-ide.org"
SRC_URI=""
EGIT_REPO_URI="git://github.com/scala-ide/scala-ide.git"

LICENSE="Scala"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/jre"
RDEPEND="${DEPEND}
		dev-java/maven-bin:3.0"

src_compile(){
	cd "${S}"
	./build-all
}

src_install() {

	die "not yet implemented"
	dodir /usr/{bin,share/"${P}"}
	cp -r "${S}"/* "${D}"/usr/share/"${P}"
	dosym /usr/share/"${P}"/eclipse /usr/bin/eclipse
}
