# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )
inherit distutils-r1 git-r3

DESCRIPTION='A simple backup system'
HOMEPAGE='https://github.com/BenjaminSchubert/Pyckup'
SRC_URI=''
EGIT_REPO_URI='https://github.com/BenjaminSchubert/Pyckup.git'

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE='test doc'

DEPEND='
	test? ( net-misc/rsync )
'
RDEPEND='
	net-misc/rsync
'
DOCS='
	doc
	README.md
'

python_test() {
	${PYTHON} -m unittest || die 'tests failed'
}

python_install_all() {
	distutils-r1_python_install_all

	rm -r "${D}/usr/share/doc"
}
