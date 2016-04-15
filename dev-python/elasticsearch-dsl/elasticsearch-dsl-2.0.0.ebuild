# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )

inherit distutils-r1

DESCRIPTION='High level Python client for Elasticsearch'
HOMEPAGE='https://github.com/elastic/elasticsearch-dsl-py'
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND='
	>=dev-python/elasticsearch-py-2.0.0
	dev-python/six
	dev-python/python-dateutil
'
RDEPEND="
	${DEPEND}
"
