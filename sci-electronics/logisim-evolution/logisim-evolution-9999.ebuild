# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit java-pkg-2 java-ant-2 git-r3

DESCRIPTION='A graphical tool for designing and simulating logic circuits'
HOMEPAGE='https://github.com/reds-heig/logisim-evolution.git'
SRC_URI=''
EGIT_REPO_URI="https://github.com/reds-heig/${PN}.git"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE="
	${JAVA_PKG_IUSE}
"

CDEPEND="
	${NV_DEPEND}
	>=virtual/jdk-1.7:*
"

DEPEND="
	${CDEPEND}
"
RDEPEND="
	${CDEPEND}
"

src_install() {
	java-pkg_newjar "${PN}.jar"

	java-pkg_dolauncher
}
