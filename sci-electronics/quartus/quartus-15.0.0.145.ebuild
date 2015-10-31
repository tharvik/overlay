# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit udev

HIGH_PV="${PV%.*.*}"
LOW_PV="${PV##*.}"
CARDS=( arria2 arria10p{1..3} arria5{,gz} cyclone{4,5} max{2,10} stratix{4,5} )
# TODO add max5 which is the same as max2

DESCRIPTION='The complete suite of Altera design tools'
HOMEPAGE='https://www.altera.com/'
SRC_URI="http://download.altera.com/akdlm/software/acdsinst/${HIGH_PV}/${LOW_PV}/ib_tar/Quartus-${PV}-linux-complete.tar"

LICENSE=''
SLOT='0'
KEYWORDS='~amd64'
IUSE='doc'
for c in "${CARDS[@]}"
do
	IUSE+=" ${c}"
done
REQUIRED_USE='
	arria10p2? ( arria10p1 arria10p3 )
	'
COMMON_DEPEND='
	dev-lang/tcl
	dev-libs/expat[abi_x86_32(-)]
	dev-tcltk/tcllib
	media-fonts/font-xfree86-type1
	media-libs/libcanberra[abi_x86_32(-)]
	media-libs/libpng:1.2[abi_x86_32(-)]
	media-libs/fontconfig[abi_x86_32(-)]
	media-libs/freetype:2[abi_x86_32(-)]
	sys-apps/util-linux[abi_x86_32(-)]
	sys-libs/ncurses[abi_x86_32(-)]
	sys-libs/zlib[abi_x86_32(-)]
	x11-libs/gtk+:2[abi_x86_32(-)]
	x11-libs/libICE[abi_x86_32(-)]
	x11-libs/libSM[abi_x86_32(-)]
	x11-libs/libX11[abi_x86_32(-)]
	x11-libs/libXau[abi_x86_32(-)]
	x11-libs/libXdmcp[abi_x86_32(-)]
	x11-libs/libXext[abi_x86_32(-)]
	x11-libs/libXft[abi_x86_32(-)]
	x11-libs/libXrender[abi_x86_32(-)]
	x11-libs/libXt[abi_x86_32(-)]
	x11-libs/libXtst[abi_x86_32(-)]
	virtual/libc
	'
DEPEND="
	${DEPEND}
	dev-tcltk/expect
	"
RDEPEND="${DEPEND}"

ENVD="99${PN}"
UDEV_RULES="99-${PN}"

S="${WORKDIR}"

src_prepare() {
	cat > "${ENVD}" <<-EOF || die
	PATH="${PREFIX}/opt/altera/${PN}/bin"
	EOF

	cat > "${UDEV_RULES}" <<-EOF || die
	SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
	SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
	SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"
	SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
	SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
	EOF
}

src_compile() {

	local answers=''

	# skip licences
	for i in {1..83}
	do
		answers+=' '
	done 
	answers+=y		# accept license
	
	answers+=' '	# install path
	answers+=y		# want to install quartus
	answers+=$(usex doc y n)

	local got_card=n
	local answers_tmp=''
	for c in "${CARDS[@]}"
	do
		answers_tmp+=$(usex "${c}" y n)
		if [ ${got_card} = n ] && use "${c}"
		then
			got_card=y
		fi
	done
	answers+=${got_card}
	if [ ${got_card} = y ]
	then
		answers+="${answers_tmp}"
	fi

	answers+=nnnn	# not modelsim{start,final}, dsp, sdk
	answers+=y		# confirm

	answers+=n	# want shortcuts on Desktop?
	answers+=n	# do not launch quartus
	answers+=n	# give feedback

	echo ">>>>\"${answers}\""

	for i in $(seq ${#answers})
	do
		local e="${answers:${i}:1}"
		if [ "${e}" = ' ' ]
		then
			e=''
		fi
		echo -e "${e}\r"
	done | ./setup.sh --installdir "${T}/opt/altera/" || die
}

src_install() {
	doenvd "${ENVD}"

	udev_dorules "${UDEV_RULES}"

	mv "${T}/opt" "${D}/"
}

pkg_postinst() {
	udev_reload
}
