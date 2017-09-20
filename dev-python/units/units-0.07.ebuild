# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION='python support for quantities with units'
HOMEPAGE='https://bitbucket.org/adonohue/units/'
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE='PSF-2'
SLOT='0'
KEYWORDS='~amd64 ~x86'
IUSE='test'

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

python_test() {
	py.test --doctest-modules || die 'failed test'
}
