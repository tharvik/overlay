# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="kconfig, which supports the pushd/popd directives"
HOMEPAGE="http://gittup.org/gittup/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/gittup/kconfig.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-util/tup"
RDEPEND=""

src_prepare()
{
	default

	tup init || die 'unable to init'
}

src_compile()
{
	addwrite "${ROOT}/dev/fuse"
	addwrite /proc
	tup || die 'unable to build'
}

src_install()
{
	dobin tup-conf tup-mconf
}
