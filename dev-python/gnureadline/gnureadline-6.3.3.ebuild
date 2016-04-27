# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# TODO unbundle readline

PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )

inherit distutils-r1

DESCRIPTION='Python readline extension linked against GNU readline'
HOMEPAGE='https://github.com/ludwigschwardt/python-gnureadline'
SRC_URI="https://github.com/ludwigschwardt/python-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND=''
RDEPEND=''

S="${WORKDIR}/python-${P}"
