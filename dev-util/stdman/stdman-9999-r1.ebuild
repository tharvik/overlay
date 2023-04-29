# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION='Formatted C++ stdlib man pages from cppreference'
HOMEPAGE='https://github.com/jeaye/stdman'

EGIT_REPO_URI='https://github.com/jeaye/stdman'
SRC_URI="https://upload.cppreference.com/mwiki/images/1/16/html_book_20190607.tar.xz -> ${PN}-pages.tar.xz"

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND='
	www-client/elinks
'
RDEPEND=''

src_unpack() {
	git-r3_checkout

	cd "${S}" ||
		die 'cd to cloned src'
	unpack "${PN}-pages.tar.xz"
}

src_prepare() {
	default

	sed -e '/gzip/d' -i do_* ||
		die 'unable to remove compression'
}

src_compile() {
	emake generate
}
