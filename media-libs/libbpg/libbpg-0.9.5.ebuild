# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION=""
HOMEPAGE="http://bellard.org/bpg/"
SRC_URI="http://bellard.org/bpg/${P}.tar.gz"

LICENSE="LGPL BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/sdl-image"
RDEPEND="${DEPEND}"

src_configure() {
	sed -i "s/^prefix=/prefix=$(echo "${D}" | sed 's/\//\\\//g')/" Makefile || die
}

src_install() {
	dodir '/usr/local/bin'

	emake install
}
