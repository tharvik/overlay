# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION='Better Portable Graphics library'
HOMEPAGE='http://bellard.org/bpg/'
SRC_URI="http://bellard.org/bpg/${P}.tar.gz"

LICENSE='LGPL-2.1 BSD GPL-2'
SLOT='0'
KEYWORDS='~amd64'
IUSE='tools'

RDEPEND='
	media-libs/libpng:0
	virtual/jpeg:0

	tools? (
		media-libs/libsdl
		media-libs/sdl-image
	)
	'
DEPEND="
	${RDEPEND}
	dev-lang/yasm
	dev-util/cmake
"

src_configure() {
	# build tools as asked
	sed -i "s|^#\?\s*USE_BPGVIEW=.*$|$(usex tools 'USE_BPGVIEW=y' '')|" \
		Makefile || die 'unable to select tools'

	# remove custom variables
	for v in CC CXX AR CFLAGS LDFLAGS
	do
		sed -i "s|^${v}:\?=.*||" Makefile || die 'unable to remove flags'
	done
	sed -i 's|CFLAGS+=-g||' Makefile || die 'unable to remove flags'

	# apply to go to shared library
	epatch "${FILESDIR}/${P}-shared-lib.patch"
}

src_install() {
	if use tools
	then
		dobin bpgenc bpgdec bpgview
	fi

	dolib "${PN}.so"

	insinto /usr/include
	doins libbpg.h
}
