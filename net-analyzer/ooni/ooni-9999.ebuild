# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module git-r3

DESCRIPTION='Measure internet censorship and network interference'
HOMEPAGE='https://ooni.org'

EGIT_REPO_URI='https://github.com/ooni/probe-cli'

LICENSE='BSD'
SLOT='0'
KEYWORDS=''
IUSE='test'

src_unpack() {
	git-r3_src_unpack

	go-module_live_vendor
}

src_compile() {
	go build ./cmd/ooniprobe ||
		die 'fail to build cmd/ooniprobe'
}

src_test() {
	go test ./... ||
		die 'fail to run tests'
}

src_install() {
	dobin ooniprobe
}
