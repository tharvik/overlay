# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module git-r3

DESCRIPTION='DownLoader, very customisable file fetcher'
HOMEPAGE='https://github.com/tharvik/dl'

EGIT_REPO_URI='https://github.com/tharvik/dl'

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
	git-r3_src_unpack

	go-module_live_vendor
}

src_compile() {
	go build ./cmd/dl ||
		die 'fail to build cmd/dl'
}

src_test() {
	PATH=$PWD:$PATH go test -short ./... ||
		die 'fail to run tests'
}

src_install() {
	dobin dl dl-*
}
