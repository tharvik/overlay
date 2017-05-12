# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit linux-info git-r3

DESCRIPTION='Tup is a file-based build system.'
HOMEPAGE='http://gittup.org/tup/'
SRC_URI=''
EGIT_REPO_URI='git://github.com/gittup/tup.git'

LICENSE='GPL-2'
SLOT=0
KEYWORDS=''
IUSE='suid'

DEPEND='
	sys-fs/fuse
'
RDEPEND="${DEPEND}"

DOCS='README.md'
HTML_DOCS='docs'

CONFIG_CHECK='FUSE_FS'

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
	einstalldocs

	use suid && fperms u+s /usr/bin/tup
}
