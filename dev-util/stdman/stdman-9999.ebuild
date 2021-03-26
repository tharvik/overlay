# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3

DESCRIPTION='Formatted C++11/14 stdlib man pages (cppreference)'
HOMEPAGE='https://github.com/jeaye/stdman'

EGIT_REPO_URI='https://github.com/jeaye/stdman'
SRC_URI=''

LICENSE='MIT'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND=''
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i '/gzip/d' do_install ||
		die 'unable to remove compression'
}
