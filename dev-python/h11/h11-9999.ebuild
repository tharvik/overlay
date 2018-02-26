# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1 git-r3

DESCRIPTION='bring-your-own-I/O implementation of HTTP/1.1'
HOMEPAGE='https://github.com/njsmith/h11'
SRC_URI=''
EGIT_REPO_URI='https://github.com/njsmith/h11.git'

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE='test'

DEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)
"
RDEPEND=''
