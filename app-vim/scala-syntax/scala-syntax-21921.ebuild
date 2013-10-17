# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $$

EAPI=5
SLOT=0
DESCRIPTION="vim plugin: Scala source file syntax highlighting"
HOMEPAGE="https://lampsvn.epfl.ch/trac/scala/browser/scala-tool-support/trunk/src/vim"
LICENSE="vim.org"
KEYWORDS="~amd64"
SRC_URI="https://lampsvn.epfl.ch/trac/scala/browser/scala-tool-support/trunk/src/vim/ftdetect/scala.vim
		https://lampsvn.epfl.ch/trac/scala/browser/scala-tool-support/trunk/src/vim/indent/scala.vim
		https://lampsvn.epfl.ch/trac/scala/browser/scala-tool-support/trunk/src/vim/syntax/scala.vim"
IUSE=""

src_install() {

	dodir /usr/share/vim/vimfiles/{ftdetect,indent,syntax}

}
