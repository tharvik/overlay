# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs eutils git-r3 flag-o-matic

DESCRIPTION='a fast, lightweight, vim-like browser based on webkit'
HOMEPAGE='http://fanglingsu.github.io/vimb/'
SRC_URI=''
EGIT_REPO_URI="https://github.com/fanglingsu/${PN}.git"
EGIT_BRANCH='webkit2'

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE=''

RDEPEND='
	>=net-libs/webkit-gtk-2.3.5:4
'
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	sed -i 's,\$(EXTPREFIX),$(DESTDIR)$(EXTPREFIX),' Makefile || \
		die 'unable to fix install prefix'

	sed -i 's,/lib/,/lib64/,' config.mk || \
		die 'unable to fix lib install prefix'

	default
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
}
