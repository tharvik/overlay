# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools wxwidgets

DESCRIPTION='Distributed creation of abstract art with mathematics'
HOMEPAGE='https://electricsheep.org/'
SRC_URI=''
EGIT_REPO_URI="https://github.com/scottdraves/${PN}"

LICENSE='GPL-2'
SLOT='0'
KEYWORDS=''
IUSE=''

WX_GTK_VER='3.0'

DEPEND="
	dev-lang/lua:0
	dev-libs/tinyxml
	gnome-base/libgtop
	media-libs/glee
	media-libs/libsdl2
	virtual/ffmpeg[encode]
	x11-libs/wxGTK:${WX_GTK_VER}
	x11-misc/flam3

"
RDEPEND="${DEPEND}"

S="${S}/client_generic"

pkg_setup() {
	setup-wxwidgets
}

src_prepare() {
	eautoreconf

	default
}
