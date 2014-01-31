# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/girara/girara-0.1.6-r300.ebuild,v 1.1 2013/06/13 22:32:52 xmw Exp $

EAPI=5
inherit multilib toolchain-funcs git-2

DESCRIPTION="A library that implements a user interface that focuses on simplicity and minimalism"
HOMEPAGE="http://pwmt.org/projects/girara/"
EGIT_REPO_URI=${EGIT_REPO_URI:-"git://pwmt.org/girara.git"}
SRC_URI=""

LICENSE="ZLIB"
SLOT="2"
KEYWORDS=""
IUSE="static-libs"

RDEPEND=">=x11-libs/gtk+-2.18.6"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	mygiraraconf=(
		PREFIX="${EPREFIX}"/usr
		LIBDIR='${PREFIX}'/$(get_libdir)
		GIRARA_GTK_VERSION=2
		CC="$(tc-getCC)"
		SFLAGS=""
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_prepare() {
	# Remove 'static' and 'install-static' targets
	if ! use static-libs; then
		sed -i \
			-e '/^${PROJECT}:/s:static::' \
			-e '/^install:/s:install-static::' \
			Makefile || die
	fi
}

src_compile() {
	emake "${mygiraraconf[@]}"
}

src_install() {
	emake "${mygiraraconf[@]}" install
	dodoc AUTHORS

	rm -rf "${ED}"/usr/include/${PN}
}