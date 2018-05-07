# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1 git-r3

DESCRIPTION='Yet another Python library for Grafana API'
HOMEPAGE='https://github.com/m0nhawk/grafana_api'
SRC_URI=''
EGIT_REPO_URI='https://github.com/m0nhawk/grafana_api.git'

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE='test'

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"
DEPEND="
	test? ( ${RDEPEND} )
"
