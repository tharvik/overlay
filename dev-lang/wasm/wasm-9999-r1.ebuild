# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION='WebAssembly reference interpreter'
HOMEPAGE='http://webassembly.github.io/'
SRC_URI=''
EGIT_REPO_URI='https://github.com/WebAssembly/spec.git'

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS=''
IUSE='ocamlopt test'
RESTRICT='!test? ( test )'

DEPEND='
	dev-ml/menhir
'
BDEPEND='
	dev-ml/dune
'
RDEPEND="${DEPEND}"

S="${S}/interpreter"

src_test() {
	# `test` is not concurrent friendly, see #1679
	emake unittest
	emake wasm
}
