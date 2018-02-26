# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )
inherit distutils-r1 git-r3

DESCRIPTION='Web microframework based on asyncio'
HOMEPAGE='https://pgjones.gitlab.io/quart'
SRC_URI=''
EGIT_REPO_URI='https://gitlab.com/pgjones/quart.git'

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE='test'

CDEPEND="
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/blinker[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/h11[${PYTHON_USEDEP}]
	dev-python/h2[${PYTHON_USEDEP}]
	dev-python/itsdangerous[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/multidict[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]
"
DEPEND="
	${CDEPEND}

	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"
