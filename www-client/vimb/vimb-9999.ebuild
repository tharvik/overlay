# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 savedconfig toolchain-funcs

DESCRIPTION='a fast, lightweight, vim-like browser based on webkit'
HOMEPAGE='http://fanglingsu.github.io/vimb/'
EGIT_REPO_URI="https://github.com/fanglingsu/vimb.git"

LICENSE='GPL-3'
SLOT='3'
KEYWORDS=''
IUSE='savedconfig'

RDEPEND='
	x11-libs/gtk+:3
	>=net-libs/webkit-gtk-2.20.0:4
'
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	default
	restore_config config.def.h
}

src_compile() {
	emake PREFIX="/usr"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	save_config src/config.def.h
}
