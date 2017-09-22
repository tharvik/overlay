# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit findlib git-r3

DESCRIPTION='WebAssembly reference interpreter'
HOMEPAGE='http://webassembly.github.io/'
SRC_URI=''
EGIT_REPO_URI='https://github.com/WebAssembly/spec.git'

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE='debug test'

DEPEND="
	>=dev-lang/ocaml-4.02
"
RDEPEND="
	${DEPEND}
"

S="${S}/interpreter"
DOCS=( README.md )

src_compile() {
	emake "$(usex debug un '')opt"
}

src_test() {
	emake _tags

	emake "$(usex debug debug '')test"
}

src_install() {
	newbin "${PN}$(usex debug .debug '')" "${PN}"

	einstalldocs
}
