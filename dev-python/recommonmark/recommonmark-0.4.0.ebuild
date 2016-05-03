# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )

inherit distutils-r1

DESCRIPTION='A markdown parser based on docutils'
HOMEPAGE='https://pypi.python.org/pypi/recommonmark/0.4.0'
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE='MIT'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND=''
RDEPEND='
	<=dev-python/commonmark-0.5.4
	>=dev-python/docutils-0.11
'
