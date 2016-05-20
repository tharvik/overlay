# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5} )

inherit distutils-r1 git-r3

DESCRIPTION='Python interface to nexpose'
HOMEPAGE='https://github.com/tharvik/nexpose'
SRC_URI=''
EGIT_REPO_URI='https://github.com/tharvik/nexpose.git'

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

python_test() {
	einfo 'You need to set'
	einfo ' - NEXPOSE_URL to the url to connect to nexpose'
	einfo ' - NEXPOSE_ACCESS_KEY to the API access from nexpose'
	einfo ' - NEXPOSE_SECRET_KEY to the API secret from nexpose'
	einfo " - NEXPOSE_TARGETS to a list of test target, separated by '|'"
	python -m unittest discover || die
}
