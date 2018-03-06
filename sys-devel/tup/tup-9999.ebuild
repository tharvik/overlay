# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info git-r3

DESCRIPTION='Tup is a file-based build system.'
HOMEPAGE='http://gittup.org/tup/'
SRC_URI=''
EGIT_REPO_URI='https://github.com/gittup/tup.git'

LICENSE='GPL-2'
SLOT=0
KEYWORDS=''
IUSE='suid test'

DEPEND='
	test? (
		sys-fs/fuse:0
	)
'
RDEPEND='
	sys-fs/fuse:0
'

DOCS='README.md'
HTML_DOCS='docs'

CONFIG_CHECK='FUSE_FS'

src_prepare() {
	if use test && [ "$PACKAGE_MANAGER" = 'paludis' ]
	then
		rm 'test/t4047-open-fds.sh' || \
			die 'unable to remove paludis unfriendly test'
	fi

	default
}

src_compile() {
	./bootstrap-nofuse.sh || die
}

src_test() {
	addwrite /proc
	addwrite /dev/fuse

	cd test || die 'upstream moved test directory'
	./test.sh || die
}

src_install() {
	dobin ./tup

	doman tup.1
	einstalldocs

	use suid && fperms u+s /usr/bin/tup
}
