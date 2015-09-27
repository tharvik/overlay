# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-2

DESCRIPTION="kconfig, which supports the pushd/popd directives"
HOMEPAGE="http://gittup.org/gittup/"
SRC_URI=""
EGIT_REPO_URI="git://gittup.org/kconfig.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-devel/tup"
RDEPEND=""

src_prepare()
{
	tup init
}

src_compile()
{
	addwrite "${ROOT}/dev/fuse"
	tup
}

src_install()
{
	dobin tup-conf tup-mconf
}
