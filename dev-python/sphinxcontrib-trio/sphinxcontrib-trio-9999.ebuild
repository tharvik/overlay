# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1 git-r3

DESCRIPTION='Improve sphinx support of python'
HOMEPAGE='https://github.com/python-trio/sphinxcontrib-trio'
SRC_URI=''
EGIT_REPO_URI='https://github.com/python-trio/sphinxcontrib-trio.git'

LICENSE='|| ( MIT Apache-2.0 )'
SLOT='0'
KEYWORDS=''
IUSE='test'

CDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
"
DEPEND="
	${CDEPEND}

	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/async-generator[${PYTHON_USEDEP}]
		dev-python/contextlib2[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/cssselect[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"
