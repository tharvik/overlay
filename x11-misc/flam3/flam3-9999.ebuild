# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION='The original fractal flame renderer and genetic language'
HOMEPAGE='http://flam3.com/'
EGIT_REPO_URI="https://github.com/scottdraves/${PN}.git"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''

DEPEND='
	dev-libs/libxml2:2
	media-libs/libjpeg-turbo:0
	media-libs/libpng:0
	sys-libs/zlib:0
'
RDEPEND="${DEPEND}"

src_prepare()
{
	eautoreconf

	default
}
