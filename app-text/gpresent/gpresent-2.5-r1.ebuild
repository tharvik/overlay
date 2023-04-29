# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION='Presentations with sys-apps/groff'
HOMEPAGE='https://bob.diertens.org/corner/useful/gpresent'
SRC_URI="https://bob.diertens.org/corner/useful/gpresent/${P}.tar.gz"

LICENSE='GPL-2'
SLOT='0'
KEYWORDS='~amd64 ~x86'
IUSE=''

DEPEND=''
RDEPEND='>=dev-lang/perl-5:*'

S="${WORKDIR}"

DOCS=( README )

src_install() {
	default

	insinto /usr/share/groff/site-tmac
	doins *.tmac

	dobin presentps

	doman *.{1,7}
}
