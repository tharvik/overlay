# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils autotools
DESCRIPTION="The headers of GNU Mach"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach"
SRC_URI="http://git.sv.gnu.org/cgit/hurd/gnumach.git/snapshot/gnumach-727da7816336e95a1658d77d1da4c3974d4eb2b1.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="sys-devel/binutils[-nls]"
EGIT_REPO_URI="git://git.sv.gnu.org/hurd/gnumach.git"

src_unpack() {
	default_src_unpack
	mv "${WORKDIR}"/gnumach-* "${WORKDIR}"/"${P}"
	
	cd "${S}"
	eautoreconf -vi
}

src_configure() {
	cd "${T}"
	ECONF_SOURCE="${S}"

	# host: workaround to compile
	econf --prefix= --host=i686-unknown-linux-gnu || die
}

src_install() {
	cd "${T}"
	emake DESTDIR="${D}"/usr install-data || die
}
