# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION='A robust two way (bidirectional) file sync script based on rsync with fault tolerance'
HOMEPAGE='http://www.netpower.fr/osync'
SRC_URI="https://github.com/deajan/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE='osync'
SLOT='0'
KEYWORDS='~amd64'
IUSE='doc'

DEPEND='
	doc? ( app-office/lyx )
'
RDEPEND='
	app-shells/bash
	net-misc/rsync
	sys-apps/coreutils
	sys-process/procps
	virtual/ssh
'
src_prepare() {
	# remove check for configuration file ending in .conf
	sed -i 's|"\.conf"|"$1"|' "${PN}.sh"
}

src_compile() {
	use doc && lyx 'Osync v1.00a.lyx' -e text
}

src_install() {
	use doc && newdoc 'Osync v1.00a.txt' "${PN}"

	newconfd sync.conf osync

	dobin "${PN}.sh"
	dobin "${PN}-batch.sh"
	dobin ssh_filter.sh

	newinitd "${FILESDIR}/${PV}-init.d" "${PN}"
}

pkg_postinst() {
	einfo 'You need to update the configuration to have sensible settings.'
}
