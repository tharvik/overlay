# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION='A Python to Vega translator'
HOMEPAGE='https://github.com/wrobstory/vincent'
SRC_URI="
	https://github.com/wrobstory/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE='MIT'
SLOT='0'
KEYWORDS='~amd64 ~x86'
IUSE='test'

CDEPEND='
	dev-python/pandas
'
DEPEND="
	${CDEPEND}
	test? (
		dev-python/flake8
		dev-python/mock
		dev-python/nose
	)
"
RDEPEND="${CDEPEND}"

python_test() {
	flake8 --exclude=colors.py,_compat.py vincent tests || die
	nosetests || die
}
