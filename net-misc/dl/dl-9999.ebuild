# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION='DownLoader, very customisable file fetcher'
HOMEPAGE='https://github.com/tharvik/dl'
SRC_URI=''

EGIT_REPO_URI='https://github.com/tharvik/dl.git'

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE='debug test'

DEPEND='
	dev-haskell/acid-state
	dev-haskell/flock
	dev-haskell/hinotify
'
RDEPEND="${DEPEND}"
BDEPEND='
	dev-util/tup
	test? ( sys-process/time )
'

get_variant() {
	usex debug debug release
}

src_compile() {
	addwrite /proc:/dev/fuse

	tup variant variant/$(get_variant) ||
		die 'unable to select variant'
	tup build-$(get_variant)/src ||
		die 'unable to build variant: $variant'
}

src_test() {
	tup build-$(get_variant)/test
}

src_install() {
	dobin build-$(get_variant)/src/dl
	dobin dl-gen-*
}
