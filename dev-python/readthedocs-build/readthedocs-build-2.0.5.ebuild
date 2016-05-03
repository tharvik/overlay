# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )

inherit distutils-r1

DESCRIPTION='Build infrastructure for Read the Docs'
HOMEPAGE='https://readthedocs.org/'
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE='MIT'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND=''
RDEPEND='
	>=dev-python/pyyaml-3.0
	>=dev-python/sphinx-1.3
	dev-python/docutils
	dev-python/readthedocs-sphinx-ext
	dev-python/recommonmark
	>=dev-python/click-4.0
	dev-python/virtualenv
'
