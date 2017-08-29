# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION='The original fractal flame renderer and genetic language'
HOMEPAGE='http://flam3.com/'
SRC_URI=''
EGIT_REPO_URI="https://github.com/scottdraves/${PN}.git"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND='
	dev-libs/libxml2:2
	media-libs/libpng:0
	sys-libs/zlib
	virtual/jpeg:0
'
RDEPEND="${DEPEND}"

src_prepare()
{
	eautoreconf

	default
}
