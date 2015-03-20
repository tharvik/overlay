# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION='C++ OpenGL'
HOMEPAGE='https://github.com/tharvik/COG'

SRC_URI=''
EGIT_REPO_URI='git://github.com/tharvik/COG.git'

LICENSE=''
SLOT='0'
KEYWORDS=''
IUSE=''

DEPEND='
	media-libs/freeglut
	media-libs/glew
	sci-physics/bullet
	virtual/glu
	virtual/opengl
	'
RDEPEND="${DEPEND}"
