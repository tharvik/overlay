# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils
DESCRIPTION="sbt"
HOMEPAGE="http://scalasbt.artifactoryonline.com/"
SRC_URI="http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.12.2/sbt.tgz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="virtual/jre"

src_unpack() {
	default_src_unpack || die
	mkdir "${S}"
	mv "${WORKDIR}"/sbt/* "${S}"
}

src_install() {
	dodir /usr/share/"${PF}" /bin
	cp -r "${S}"/* "${D}"/usr/share/"${PF}"
	dosym /usr/share/"${PF}"/bin/sbt /bin/sbt
}
