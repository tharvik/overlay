# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1 git-r3

DESCRIPTION='typing module for <dev-lang/python-3.5'
HOMEPAGE='https://github.com/python/typing'
SRC_URI=''
EGIT_REPO_URI="https://github.com/python/${PN}.git"

LICENSE='PSF-2.4'
SLOT='0'
KEYWORDS=''
IUSE='test'

DEPEND="
	test? (
		>=dev-python/pytest-2.8[${PYTHON_USEDEP}]
		>=dev-python/pytest-xdist-1.13[${PYTHON_USEDEP}]
		>=dev-python/pytest-cov-2.4.0[${PYTHON_USEDEP}]
	)
"
RDEPEND=''

python_test() {
	py.test $(usex python_targets_python2_7 python2 src)
}
