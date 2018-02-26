# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1 git-r3

DESCRIPTION='HTTP/2 State-Machine based protocol implementation'
HOMEPAGE='http://hyper.rtfd.org'
SRC_URI=''
EGIT_REPO_URI='https://github.com/python-hyper/hyper-h2.git'

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE='test'

CDEPEND="
	>=dev-python/hyperframe-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/hpack-2.3[${PYTHON_USEDEP}]

	$(python_gen_cond_dep 'virtual/python-enum34[${PYTHON_USEDEP}]' -2 python3_3)
"
DEPEND="
	${CDEPEND}

	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"
