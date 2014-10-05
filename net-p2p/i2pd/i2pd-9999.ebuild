# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

[[ ${PV} == 9999 ]] && inherit git-2

DESCRIPTION='i2p router for Linux written on C++'
HOMEPAGE='https://github.com/PrivacySolutions/i2pd'
if [ ${PV} == 9999 ]
then
	SRC_URI=''
	EGIT_REPO_URI='git://github.com/PrivacySolutions/i2pd.git'
else
	SRC_URI="http://youtube-dl.org/downloads/${PV}/${P}.tar.gz"
fi
KEYWORDS=''

LICENSE='GPL-2'
SLOT='0'
KEYWORDS=''
IUSE='debug'

DEPEND='
	>=dev-libs/boost-1.46:*
	dev-libs/crypto++
	'
RDEPEND="${DEPEND}"

src_prepare() {
	use debug &&
		sed 's/ -g / /' Makefile.linux
}

src_install() {
	dobin 'i2p'
}
