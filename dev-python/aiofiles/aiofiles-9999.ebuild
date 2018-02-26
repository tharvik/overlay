# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1 git-r3

DESCRIPTION='File support for asyncio'
HOMEPAGE='https://github.com/Tinche/aiofiles'
SRC_URI=''
EGIT_REPO_URI='https://github.com/Tinche/aiofiles.git'

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE='test'
REQUIRED_USE='test? ( !python_targets_python3_4 )'

DEPEND="
	test? (
		$(python_gen_any_dep '
			dev-python/coverage[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/pytest-asyncio[${PYTHON_USEDEP}]
			dev-python/pytest-cov[${PYTHON_USEDEP}]' python3_{5,6} )
	)
"
RDEPEND=''
