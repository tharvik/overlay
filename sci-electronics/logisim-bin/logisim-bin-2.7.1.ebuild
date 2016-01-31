# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit java-pkg-2

MY_PN='logisim'

DESCRIPTION='A graphical tool for designing and simulating logic circuits'
HOMEPAGE='http://www.cburch.com/logisim'
SRC_URI="mirror://sourceforge/project/circuit/2.7.x/${PV}/${MY_PN}-generic-${PV}.jar -> ${P}.jar"

LICENSE='GPL-2'
SLOT='0'
KEYWORDS='~amd64'
IUSE="
	${JAVA_PKG_IUSE}
"

DEPEND="
	>=virtual/jdk-1.5:*
	${NV_DEPEND}
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}"

src_install() {
	java-pkg_newjar "${DISTDIR}/${P}.jar"

	java-pkg_dolauncher
}
