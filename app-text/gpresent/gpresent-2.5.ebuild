# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit perl-functions

DESCRIPTION='Presentations with sys-apps/groff'
HOMEPAGE='https://staff.fnwi.uva.nl/b.diertens/useful/gpresent'
SRC_URI="https://staff.fnwi.uva.nl/b.diertens/useful/${PN}/${P}.tar.gz"

LICENSE='GPL-2'
SLOT='0'
KEYWORDS='~amd64 ~x86'
IUSE=''

DEPEND=''
RDEPEND='
	dev-lang/perl:*
'

S="${WORKDIR}"

src_install() {
	insinto /usr/share/groff/site-tmac
	doins *.tmac

	dobin presentps

	doman *.{1,7}
}
