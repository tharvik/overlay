# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1 git-r3

DESCRIPTION='WebSockets state-machine based protocol implementation'
HOMEPAGE='https://github.com/python-hyper/wsproto'
SRC_URI=''
EGIT_REPO_URI='https://github.com/python-hyper/wsproto.git'

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE='test'

CDEPEND="
	>=dev-python/h11-0.7.0[${PYTHON_USEDEP}]

	$(python_gen_cond_dep 'dev-python/enum34[${PYTHON_USEDEP}]' -2 python3_3)
"
DEPEND="
	${CDEPEND}

	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wsaccel[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"
