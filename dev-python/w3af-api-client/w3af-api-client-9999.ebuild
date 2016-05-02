# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4,5} )

inherit distutils-r1 git-r3

DESCRIPTION='REST API client to consume w3af'
HOMEPAGE='https://github.com/andresriancho/w3af-api-client/'
SRC_URI=''
EGIT_REPO_URI="https://github.com/tutengfei/${PN}-py3.git"

LICENSE='GPL-2'
SLOT='0'
KEYWORDS=''
IUSE='test'

DEPEND='
	>=dev-python/requests-2.3.0
	dev-python/peppercorn
'
RDEPEND="
	${DEPEND}
"
