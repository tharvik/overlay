# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 git-r3

DESCRIPTION='Library for building Grafana dashboards'
HOMEPAGE='https://github.com/weaveworks/grafanalib'
EGIT_REPO_URI='https://github.com/weaveworks/grafanalib.git'

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE='test'

RDEPEND=">=dev-python/attrs-17.1.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

RESTRICT='test'

python_test() {
	py.test || die
}
