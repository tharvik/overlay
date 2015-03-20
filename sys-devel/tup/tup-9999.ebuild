# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION='Tup is a file-based build system.'
HOMEPAGE='http://gittup.org/tup/'
EGIT_REPO_URI='git://github.com/gittup/tup.git'
SRC_URI=""

LICENSE='GPL2'
SLOT=0
KEYWORDS=''
IUSE=''

DEPEND=''
RDEPEND="${DEPEND}"

src_compile() {
	addwrite '/dev/fuse'
	./bootstrap.sh
}

src_install() {
	dobin ./tup

	doman tup.1
	dodoc README.md
	dodoc COPYING
}
