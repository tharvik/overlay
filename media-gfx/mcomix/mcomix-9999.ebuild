# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 eutils fdo-mime
[[ ${PV} == 9999* ]] && inherit subversion

DESCRIPTION="A fork of comix, a GTK image viewer for comic book archives."
HOMEPAGE="http://mcomix.sourceforge.net"

if ! [[ ${PV} == 9999* ]]; then
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI=""
	ESVN_REPO_URI="svn://svn.code.sf.net/p/mcomix/code/"
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/pygtk-2.14[${PYTHON_USEDEP}]
	virtual/jpeg
	virtual/python-imaging[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf
	!media-gfx/comix"

DOCS=( ChangeLog README )

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	echo
	elog "Additional packages are required to open most common comic files:"
	elog
	elog "    cbr: app-arch/unrar"
	elog "    cbz: app-arch/unzip"
	elog
	elog "You can also add support for 7z or LHA archives by installing"
	elog "app-arch/p7zip or app-arch/lha."
	echo
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
