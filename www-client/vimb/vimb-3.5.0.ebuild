# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig toolchain-funcs

DESCRIPTION='a fast, lightweight, vim-like browser based on webkit'
HOMEPAGE='http://fanglingsu.github.io/vimb/'
SRC_URI="https://github.com/fanglingsu/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS='~amd64 ~x86'
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
