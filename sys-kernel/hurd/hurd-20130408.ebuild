# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils autotools
DESCRIPTION="The Hurd"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach"
SRC_URI="http://git.sv.gnu.org/cgit/hurd/hurd.git/snapshot/hurd-0992a61cafb0f3def3b6997f7c3670a4474f479b.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="sys-kernel/gnumach
		sys-libs/glibc[crosscompile_opts_headers-only]"

src_unpack() {
	default_src_unpack
	mv "${WORKDIR}"/hurd-* "${WORKDIR}"/"${P}"

	cd "${S}"
	eautoreconf -vi
}

src_configure() {
	cd "${T}"
	ECONF_SOURCE="${S}"

	#CPP='gcc -m32 -E -x c -undef -ansi'	CC='gcc -m32' LD='ld -melf_i386' ../configure --prefix= --host=i686-unknow-linux-gnu || die
	econf --disable-profile --build=i686-unknow-linux-gnu --host=i686-gnu || die
}

src_compile() {
	cd "${T}"
	emake -j1 || die
}

src_install() {
	cd "${T}"
	einstall
}
