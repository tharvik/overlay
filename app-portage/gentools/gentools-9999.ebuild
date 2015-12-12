# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION='Set of tools for Gentoo'
HOMEPAGE='https://github.com/tharvik/gentools'
SRC_URI=''
EGIT_REPO_URI="https://github.com/tharvik/${PN}.git"

LICENSE='AGPL-3'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND=''
RDEPEND='
	|| (
		app-shells/bash
		app-shells/dash
	)
'

src_install() {
	find "${S}" -executable -type f ! -path '*/.git/*' | while read l
	do
		dosbin "${l}"
	done

	dodoc README.md
}
