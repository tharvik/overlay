# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4,5} )

inherit distutils-r1

MY_PV='0.5.0-1'
MY_P="${PN}-${MY_PV}"

DESCRIPTION='Python class to use nmap and access scan results'
HOMEPAGE='http://xael.org/pages/python-nmap-en.html'
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND=''
RDEPEND='
	net-analyzer/nmap
'

S="${WORKDIR}/${MY_P}"
