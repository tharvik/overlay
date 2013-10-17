# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

SLOT="0"
DESCRIPTION="vim plugin: Scala source file syntax highlighting"
HOMEPAGE="https://lampsvn.epfl.ch/trac/scala/browser/scala-tool-support/trunk/src/vim"
LICENSE="vim.org"
KEYWORDS="~amd64"
SRC_URI="https://lampsvn.epfl.ch/trac/scala/changeset?format=zip&new=21921 -> ${P}.zip"
IUSE=""

src_unpack() {
	default_src_unpack || die
	mv "${WORKDIR}"/scala-tool-support/trunk/src/vim "${S}" || die
}

src_install() {

	for f in ftdetect indent syntax
	do
		dodir /usr/share/vim/vimfiles/$f || die
		cp "${S}"/$f/scala.vim "${D}"/usr/share/vim/vimfiles/$f/ || die
	done

}
