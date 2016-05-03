# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION='Build infrastructure for Read the Docs'
HOMEPAGE='https://readthedocs.org/'
SRC_URI=''
EGIT_REPO_URI="https://github.com/rtfd/${PN}.git"

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
