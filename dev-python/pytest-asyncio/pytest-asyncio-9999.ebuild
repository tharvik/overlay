# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1 git-r3

DESCRIPTION='Pytest support for asyncio'
HOMEPAGE='https://github.com/pytest-dev/pytest-asyncio'
SRC_URI=''
EGIT_REPO_URI='https://github.com/pytest-dev/pytest-asyncio.git'

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE='test'

CDEPEND="
	>=dev-python/pytest-3.0.6[${PYTHON_USEDEP}]
"
DEPEND="
	${CDEPEND}

	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		>=dev-python/async-generator-1.3[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"
