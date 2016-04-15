# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5} )

inherit distutils-r1 git-r3

DESCRIPTION='Python interface to nessus'
HOMEPAGE='https://github.com/tharvik/nessus'
SRC_URI=''
EGIT_REPO_URI='https://github.com/tharvik/nessus.git'

LICENSE=''
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
	einfo ' - NESSUS_URL to the url to connect to nessus'
	einfo ' - NESSUS_ACCESS_KEY to the API access from nessus'
	einfo ' - NESSUS_SECRET_KEY to the API secret from nessus'
	einfo " - NESSUS_TARGETS to a list of test target, separated by '|'"
	python -m unittest discover || die
}
