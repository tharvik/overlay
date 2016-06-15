# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION='Some scripts related to youtube-dl and autosync with tup'
HOMEPAGE='https://github.com/tharvik/youtube-dl_scripts'
SRC_URI=''
EGIT_REPO_URI="https://github.com/tharvik/${PN}.git"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND=''
RDEPEND='
	net-misc/youtube-dl
	sys-devel/tup
'

src_install() {
	dobin $(find -maxdepth 1 -type f -executable)
}
