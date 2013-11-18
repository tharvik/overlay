# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="A command-line client for mega.co.nz storage service"
HOMEPAGE="https://github.com/t3rm1n4l/megacmd"
SRC_URI=""
EGIT_REPO_URI="git://github.com/t3rm1n4l/megacmd.git https://github.com/t3rm1n4l/megacmd.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-libs/go-mega"
RDEPEND="${DEPEND}"
