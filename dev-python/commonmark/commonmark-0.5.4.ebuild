# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )

MY_PN='CommonMark-py'

inherit distutils-r1

DESCRIPTION='Python parser for the CommonMark Markdown spec'
HOMEPAGE='https://github.com/rolandshoemaker/CommonMark-py'
SRC_URI="https://github.com/rolandshoemaker/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE='BSD'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND=''
RDEPEND=''

S="${WORKDIR}/${MY_PN}-${PV}"
