# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

inherit distutils-r1

DESCRIPTION='Pure-Python implementation of the AMQP'
HOMEPAGE='https://pika.readthedocs.org/ https://github.com/pika/pika'
SRC_URI="https://github.com/pika/pika/archive/0.11.2.tar.gz -> ${P}.tgz"

LICENSE='BSD'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND=''
RDEPEND=''
