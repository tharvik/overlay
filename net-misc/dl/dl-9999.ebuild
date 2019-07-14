# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit golang-build golang-vcs

DESCRIPTION='DownLoader, very customisable file fetcher'
HOMEPAGE='https://github.com/tharvik/dl'

EGO_PN='github.com/tharvik/dl'

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE='test'

BDEPEND='
	test? (
		app-shells/bash:0
		sys-process/time
	)
'

src_unpack() {
	for pn in github.com/tharvik/flock $EGO_PN
	do
		EGO_PN=$pn golang-vcs_src_unpack
	done
}

src_test() {
	PATH="$S:$S/src/github/tharvik/dl:$PATH" golang-build_src_test
}

src_install() {
	dobin dl src/github.com/tharvik/dl/dl-*
}
