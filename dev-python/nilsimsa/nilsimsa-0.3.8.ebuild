# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )

MY_PN="py-${PN}"

inherit distutils-r1

DESCRIPTION='Locality-sensitive hashing'
HOMEPAGE='https://github.com/diffeo/py-nilsimsa/'
SRC_URI="https://github.com/diffeo/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE='MIT'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND=''
RDEPEND=''

S="${WORKDIR}/${MY_PN}-${PV}"

python_prepare_all() {
	sed -i "s|version=VERSION|version='${PV}'|" setup.py

	distutils-r1_python_prepare_all
}
