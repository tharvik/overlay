# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils autotools
DESCRIPTION="The very last git version of GNU/gnumarch"
HOMEPAGE="https://www.gnu.org/software/hurd/microkernel/mach/gnumach"
SRC_URI="http://git.sv.gnu.org/cgit/hurd/gnumach.git/snapshot/gnumach-727da7816336e95a1658d77d1da4c3974d4eb2b1.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="sys-kernel/mig"

src_unpack() {
	default_src_unpack
	mv "${WORKDIR}"/gnumach-* "${WORKDIR}"/"${P}"

	cd "${S}"
	#eautoreconf --install
	eautoreconf -vi
}

src_configure() {
	mkdir "${S}"/build
	cd "${S}"/build

	CPP='gcc -m32 -E -x c -undef -ansi'	CC='gcc -m32' LD='ld -melf_i386' ../configure --prefix= --host=i686-unknow-linux-gnu || die
}

src_compile() {
	cd "${S}"/build
	emake gnumach.gz || die
}

src_test() {
	cd "${S}"/build
	emake check || die
}

src_install() {
	mkdir -p "${D}"/usr/src/gnumach
	cp "${S}"/build/gnumach.gz "${D}"/usr/src/gnumach/
}
