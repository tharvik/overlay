# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1 git-r3

DESCRIPTION='async iterators in python 3.5'
HOMEPAGE='https://github.com/python-trio/async_generator'
SRC_URI=''
EGIT_REPO_URI='https://github.com/python-trio/async_generator.git'

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE='doc test'

DEPEND="
	doc? (
		>=dev-python/sphinx-1.6.1[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
		dev-python/sphinxcontrib-trio[${PYTHON_USEDEP}]
	)

	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)

"
RDEPEND=''
