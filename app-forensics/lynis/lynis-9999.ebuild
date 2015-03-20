# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/lynis/lynis-1.6.2.ebuild,v 1.1 2014/09/30 18:55:39 idl0r Exp $

EAPI="5"

inherit eutils bash-completion-r1
[[ ${PV} == 9999 ]] && inherit git-2

DESCRIPTION="Security and system auditing tool"
HOMEPAGE="http://cisofy.com/lynis/"

if [ ${PV} != 9999 ]
then
	SRC_URI="http://cisofy.com/files/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI=""
	EGIT_REPO_URI='https://github.com/CISOfy/Lynis.git'
	KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

S="${WORKDIR}/${PN}"

src_prepare() {
	# Bug 507438
	epatch_user
}

src_install() {
	doman lynis.8
	dodoc CHANGELOG FAQ README

	# Remove the old one during the next stabilize progress
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/lynis.cron-new lynis

	dobashcomp extras/bash_completion.d/lynis

	# stricter default perms - bug 507436
	diropts -m0700
	insopts -m0600

	insinto /usr/share/${PN}
	doins -r db/ include/ plugins/

	dosbin lynis

	insinto /etc/${PN}
	doins default.prf
}

pkg_postinst() {
	einfo
	einfo "A cron script has been installed to ${ROOT}etc/cron.daily/lynis."
	einfo
}
