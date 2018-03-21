# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
inherit distutils-r1 git-r3

DESCRIPTION='A Python Tumblr API v2 Client'
HOMEPAGE='https://github.com/tumblr/pytumblr'
SRC_URI=''
EGIT_REPO_URI="https://github.com/tumblr/${PN}.git"

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE='test'

RDEPEND="
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}

	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
"
