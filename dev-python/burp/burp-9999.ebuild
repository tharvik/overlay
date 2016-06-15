# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5} )

inherit distutils-r1 git-r3

DESCRIPTION='Python interface to burp'
HOMEPAGE='https://github.com/tharvik/burp'
SRC_URI=''
EGIT_REPO_URI='https://github.com/tharvik/burp.git'

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE='test'

DEPEND='
	dev-python/requests
	dev-python/mypy
'
RDEPEND="
	${DEPEND}
"
