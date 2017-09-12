# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 git-r3

DESCRIPTION='Optional static typing for Python'
HOMEPAGE='http://www.mypy-lang.org/'
SRC_URI=''
EGIT_REPO_URI="https://github.com/python/${PN}.git"

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE='doc test'

DEPEND="
	test? (
		dev-python/flake8[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/lxml[${PYTHON_USEDEP}]' 'python3_[5,6]' )
		>=dev-python/pytest-3.0
		>=dev-python/pytest-xdist-1.18
		>=dev-python/pytest-cov-2.4.0
		>=dev-python/typed_ast-1.1.0
	)
	doc? (
		>=dev-python/sphinx-1.4.4[${PYTHON_USEDEP}]
		>=dev-python/sphinx_rtd_theme-0.1.9[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	$(python_gen_cond_dep 'dev-python/typing[${PYTHON_USEDEP}]' 'python3_4')
"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	local PYTHONPATH="$(pwd)"

	"${PYTHON}" runtests.py -x lint || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )

	distutils-r1_python_install_all
}
