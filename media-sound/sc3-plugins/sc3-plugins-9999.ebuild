# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic git-r3

DESCRIPTION="Third party plugins for SuperCollider"
HOMEPAGE="https://github.com/supercollider/sc3-plugins"
EGIT_REPO_URI="https://github.com/supercollider/sc3-plugins.git"
LICENSE="GPL-2"
SLOT="0"

IUSE="debug"

RDEPEND="
	media-sound/supercollider
"
DEPEND="${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DSC_PATH=/usr/include/SuperCollider
		-DSUPERNOVA=ON
	)

	append-cppflags $(usex debug '' -DNDEBUG)

	cmake_src_configure
}
