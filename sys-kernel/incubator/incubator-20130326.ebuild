# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils git-2 autotools

DESCRIPTION="The very last git version of the incubator"
HOMEPAGE="https://www.gnu.org/software/hurd/toolchain/cross-gnu.html"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS="~amd64"
IUSE="" #!

SRC_URI="http://distfiles.gentoo.org/distfiles/binutils-2.22.tar.bz2
		 http://gcc.parentingamerica.com/snapshots/4.9-20130331/gcc-4.9-20130331.tar.bz2
		 http://git.sv.gnu.org/cgit/hurd/libpthread.git/snapshot/libpthread-fa9eb2c255e1d46beadcd81edd459b9c3d7dcb8c.tar.gz
		 http://git.sv.gnu.org/cgit/hurd/glibc.git/snapshot/glibc-45aaf319a9dc119105c73ac4f34373f6f30ba49f.tar.gz
		 http://git.sv.gnu.org/cgit/hurd/incubator.git/snapshot/incubator-13e58b2d59ebc3a058ca2ddc966757f656056dee.tar.gz
		 http://git.sv.gnu.org/cgit/hurd/gnumach.git/snapshot/gnumach-727da7816336e95a1658d77d1da4c3974d4eb2b1.tar.gz
		 http://git.sv.gnu.org/cgit/hurd/mig.git/snapshot/mig-495615802f3671f1656d92a8712341a9b78d8dd1.tar.gz
		 http://git.sv.gnu.org/cgit/hurd/hurd.git/snapshot/hurd-0992a61cafb0f3def3b6997f7c3670a4474f479b.tar.gz"

# Run-time dependencies. Must be defined to whatever this depends on to run.
# The below is valid if the same run-time depends are required to compile.
RDEPEND=""

src_unpack() {

	default_src_unpack || die
	mkdir -p "${S}"/src || die

	# incubator
	mv "${S}"/../incubator-1*/* "${S}"/ || die

	# binutils
	mkdir "${S}"/src/binutils || die
	mv "${S}"/../binutils*/* "${S}"/src/binutils/ || die

	# gcc
	mkdir "${S}"/src/gcc || die
	mv "${S}"/../gcc*/* "${S}"/src/gcc/ || die
	cd "${S}"/src/gcc || die
	./contrib/gcc_update --touch

	# gnumach
	mkdir "${S}"/src/gnumach || die
	mv "${S}"/../gnumach*/* "${S}"/src/gnumach/ || die
	cd "${S}"/src/gnumach || die
	eautoreconf -vi || die 

	# mig
	mkdir "${S}"/src/mig || die
	mv "${S}"/../mig*/* "${S}"/src/mig/ || die
	cd "${S}"/src/mig || die
	eautoreconf -vi || die

	# hurd
	mkdir "${S}"/src/hurd || die
	mv "${S}"/../hurd*/* "${S}"/src/hurd/ || die
	cd "${S}"/src/hurd || die
	eautoreconf -vi || die

	# libpthread
	mkdir "${S}"/src/libpthread || die
	mv "${S}"/../libpthread*/* "${S}"/src/libpthread/ || die
	cd "${S}"/src/libpthread || die
	eautoreconf -vi || die

	# glibc
	mkdir "${S}"/src/glibc || die
	mv "${S}"/../glibc*/* "${S}"/src/glibc/ || die
}

src_configure() {
	epatch "${FILESDIR}"/${P}-cross-gnu.patch || die
}

src_compile() {
	cd "${S}"
	ROOT="${S}"
	. "${S}"/cross-gnu-env || die
	"${S}"/cross-gnu || die

	die "end of it!"
}

#src_test() {
	#cd "${S}"/build
	#emake check || die
#}

#src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	# This is the preferred way to install.
	#emake DESTDIR="${D}" install || die

	# When you hit a failure with emake, do not just use make. It is
	# better to fix the Makefiles to allow proper parallelization.
	# If you fail with that, use "emake -j1", it's still better than make.

	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# The portage shortcut to the above command is simply:
	#
	#einstall || die

	#mkdir -p "${D}"/usr/src/gnumach
	#cp "${S}"/build/gnumach.gz "${D}"/usr/src/gnumach/
#}

