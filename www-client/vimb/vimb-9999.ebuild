# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 savedconfig toolchain-funcs

DESCRIPTION='a fast, lightweight, vim-like browser based on webkit'
HOMEPAGE='http://fanglingsu.github.io/vimb/'
SRC_URI=''
EGIT_REPO_URI="https://github.com/fanglingsu/${PN}.git"

LICENSE='GPL-3'
SLOT='0'
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
	sed -i "s,/lib/,/$(get_libdir)/," config.mk || \
		die 'unable to fix lib install prefix'

	use savedconfig && restore_config src/config.def.h

	default
}

src_compile() {
	emake PREFIX="${ROOT}/usr" CC="$(tc-getCC)"
}

src_install() {
	emake PREFIX="${ROOT}/usr" DESTDIR="${D}" install

	use savedconfig && save_config src/config.def.h
}
