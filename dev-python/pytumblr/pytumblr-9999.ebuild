# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1 git-r3

DESCRIPTION='A Python Tumblr API v2 Client'
HOMEPAGE='https://github.com/tumblr/pytumblr'
SRC_URI=''
EGIT_REPO_URI="https://github.com/tumblr/${PN}.git"

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND='
	dev-python/httpretty
	dev-python/oauth2
'
RDEPEND="${DEPEND}"
