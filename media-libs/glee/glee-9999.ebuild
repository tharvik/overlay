# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-multilib

DESCRIPTION='Cross-platform extension loading library for OpenGL'
HOMEPAGE='https://web.archive.org/web/20140807030923/http://elf-stone.com:80/glee.php'
SRC_URI=''
EGIT_REPO_URI="https://git.code.sf.net/p/glee/${PN}"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND='
	virtual/opengl
'
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i "s,readme.txt,Readme.txt,;s,\<lib\>,$(get_libdir)," CMakeLists.txt

	default
}
