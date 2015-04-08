# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Only the deps of vmware-workstation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="cups doc ovftool server vix vmware-tools"

RDEPEND="dev-cpp/cairomm
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	dev-cpp/libgnomecanvasmm
	dev-cpp/pangomm
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/icu
	dev-libs/expat
	dev-libs/libaio
	dev-libs/libgcrypt:0
	dev-libs/libsigc++
	dev-libs/libxml2
	=dev-libs/openssl-0.9.8*
	dev-libs/xmlrpc-c
	gnome-base/libgnomecanvas
	gnome-base/libgtop:2
	gnome-base/librsvg:2
	gnome-base/orbit
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libart_lgpl
	=media-libs/libpng-1.2*
	media-libs/libpng
	net-misc/curl
	cups? ( net-print/cups )
	sys-devel/gcc
	sys-fs/fuse
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libgksu
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango
	x11-libs/pangox-compat
	x11-libs/startup-notification
	x11-themes/hicolor-icon-theme
	!app-emulation/vmware-player"
