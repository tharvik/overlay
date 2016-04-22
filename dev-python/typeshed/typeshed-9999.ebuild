# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION='Collection of library stubs for Python, with static types'
HOMEPAGE='https://github.com/python/typeshed'
SRC_URI=''
EGIT_REPO_URI="https://github.com/python/${PN}.git"

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND=''
RDEPEND=''

src_install() {
	dodir "/usr/lib/mypy/${PN}"
	cp -r stdlib third_party "${D}/usr/lib/mypy/${PN}"
}
