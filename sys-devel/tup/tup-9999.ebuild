# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-2

DESCRIPTION='Tup is a file-based build system.'
HOMEPAGE='http://gittup.org/tup/'
EGIT_REPO_URI='git://github.com/gittup/tup.git'
SRC_URI=""

LICENSE='GPL-2'
SLOT=0
KEYWORDS=''
IUSE=''

DEPEND='
	sys-fs/fuse
'
RDEPEND="${DEPEND}"
RESTRICT='userpriv'

src_compile() {
	addwrite '/dev/fuse'
	./bootstrap.sh || die
}

src_test() {
	cd "${S}/test"
	./test.sh || die
}

src_install() {
	dobin ./tup

	doman tup.1
	dodoc README.md
}
