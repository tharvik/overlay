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

src_install() {
	cp -r "${S}" "${D}"/opt/sbt

	dodir /opt/{bin,sbt}
	dosym /opt/sbt/bin/sbt /opt/bin/sbt
}
