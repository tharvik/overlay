# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info

DESCRIPTION='Tup is a file-based build system.'
HOMEPAGE='http://gittup.org/tup/'
SRC_URI="https://github.com/gittup/tup/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE='GPL-2'
SLOT=0
KEYWORDS='~amd64 ~x86'
IUSE='suid'

DEPEND='
	sys-fs/fuse:0
'
RDEPEND="${DEPEND}"

DOCS='README.md'
HTML_DOCS='docs'

CONFIG_CHECK='FUSE_FS'

src_prepare() {
	sed -i "s,\`git describe\`,${PV},g" Tupfile || die

	default
}

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
