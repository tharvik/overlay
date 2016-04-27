# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION='The Router Exploitation Framework'
HOMEPAGE='https://github.com/reverse-shell/routersploit'
SRC_URI=''
EGIT_REPO_URI="https://github.com/reverse-shell/${PN}.git"

LICENSE='BSD'
SLOT='0'
KEYWORDS=''
IUSE='test'

DEPEND='
	dev-python/gnureadline
	dev-python/requests
	dev-python/paramiko
	dev-python/beautifulsoup:4

	test? (
		dev-python/pexpect
	)
'
DEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack

	cp "${FILESDIR}/${P}-setup.py" "${S}/setup.py" || die
}

python_prepare() {
	sed -i "s|^\(\s\+rootpath =\).*$|\1 '$(python_get_sitedir)/${PN}/modules/'|" \
		'routersploit/modules/scanners/autopwn.py'
	sed -i 's|not device.endswith(".pyc")|not device.endswith((".pyc", ".pyo"))|' \
		'routersploit/modules/scanners/autopwn.py'
}

python_test() {
	python -m unittest discover -s routersploit/test
}
