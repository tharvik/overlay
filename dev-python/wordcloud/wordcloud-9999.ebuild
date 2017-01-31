# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1 git-r3

DESCRIPTION='A little word cloud generator in Python'
HOMEPAGE='https://github.com/amueller/word_cloud'
SRC_URI=''
EGIT_REPO_URI='https://github.com/amueller/word_cloud.git'

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND="
	dev-python/matplotlib
	>=dev-python/numpy-1.6
	dev-python/pillow
"
RDEPEND="${DEPEND}"
