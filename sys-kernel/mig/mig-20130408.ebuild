# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils autotools
DESCRIPTION="The Mach Interface Generator (MIG)"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/mig/gnu_mig.html"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="sys-kernel/gnumach-header"
SRC_URI="http://git.sv.gnu.org/cgit/hurd/mig.git/snapshot/mig-495615802f3671f1656d92a8712341a9b78d8dd1.tar.gz"

src_unpack() {
	default_src_unpack
	mv "${WORKDIR}"/mig-* "${WORKDIR}"/${P}

	cd "${S}"
	eautoreconf -vi
}

src_configure() {
	cd "${T}"
	ECONF_SOURCE="${S}"

	TARGET_CPPFLAGS=-I"${ROOT}"/usr/include
	econf --prefix="${ROOT}"/usr --host=i686-unknown-linux-gnu || die
}

src_compile() {
	cd "${T}"
	emake -I"${ROOT}"/usr/include || die
}

src_install() {
	cd "${T}"
	einstall || die
}
