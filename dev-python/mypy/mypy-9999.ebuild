# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python3_3 python3_4 )

inherit distutils-r1 vcs-snapshot git-r3

DESCRIPTION="Optional static typing for Python"
HOMEPAGE="http://www.mypy-lang.org/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/python/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=''
IUSE="doc examples"

DEPEND="
	dev-python/typeshed
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
	)
"
RDEPEND=""

python_prepare_all() {
	sed -i '/typeshed/d' setup.py || die 'unable to remove typeshed'

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	"${PYTHON}" tests.py || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	use examples && local EXAMPLES=( samples/. )

	distutils-r1_python_install_all
}
