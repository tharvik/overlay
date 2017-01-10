# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_4 python3_5 )
inherit distutils-r1 git-r3

DESCRIPTION='Fork of the ast module parsing types annotations'
HOMEPAGE='https://github.com/python/typed_ast'
SRC_URI=''
EGIT_REPO_URI="https://github.com/python/${PN}.git"

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND=''
RDEPEND="${DEPEND}"
