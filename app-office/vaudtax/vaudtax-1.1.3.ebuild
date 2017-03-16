# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PV='2016'

inherit java-pkg-2 toolchain-funcs

DESCRIPTION='Tax declaration helper for Vaud in Switzerland'
HOMEPAGE='http://www.vd.ch/themes/etat-droit-finances/impots/vaudtax'
SRC_URI="https://vaudtax-dl.vd.ch/${PN}${MY_PV}/telechargement/linux/VaudTax_${MY_PV}.tar.gz"

# TODO no license found
LICENSE='all-rights-reserved'
SLOT='0'
KEYWORDS='~amd64 ~x86'
IUSE=''

DEPEND=''
RDEPEND='
	dev-java/bcmail:1.38
	dev-java/bcprov:0
	dev-java/bctsp:0
	dev-java/cdi-api:0
	dev-java/commons-codec:0
	dev-java/commons-collections:0
	dev-java/commons-configuration:0
	dev-java/commons-io:1
	dev-java/commons-httpclient:3
	dev-java/commons-lang:2.1
	dev-java/commons-lang:3.3
	dev-java/commons-logging:0
	dev-java/fontbox:1.7
	dev-java/groovy:0
	dev-java/guava:13
	dev-java/itext:0
	dev-java/jamon:2
	dev-java/javax-inject:0
	dev-java/javax-mail:0
	dev-java/jsr173:0
	dev-java/jdom:0
	dev-java/jsr305:0
	dev-java/jboss-logging:0
	dev-java/logback:0
	dev-java/lucene:1
	dev-java/lucene:2.4
	dev-java/swt:4.2[gnome]
	dev-java/pdfbox:1.8
	gnome-base/gvfs:0
	net-libs/webkit-gtk:3
	virtual/jre:1.8
'
# TODO dev-java/swt should be :4.3 but not in tree
# TODO dev-java/pdfbox should be :2.0 but not in tree

S="${WORKDIR}/VaudTax_${MY_PV}-${PV}-production"

unbundle() {
	local pkg="${1}"
	shift

	local msg='Unable to remove wanted jar'

	if [ $# -eq 0 ]
	then
		rm "${pkg}.jar" || die "${msg}"
	else
		rm "${@}" || die "${msg}"
	fi

	java-pkg_register-dependency "${pkg}"
}

dojar_and_rm() {
	java-pkg_dojar "${@}"
	rm "${@}"
}

src_install() {
	local DATADIR="/usr/share/${PN}"

	insinto "${DATADIR}"
	doins -r version.xml config/

	cd lib

	unbundle bcmail-1.38 bcmail-jdk14.jar
	unbundle bcprov bcprov-jdk14.jar
	unbundle bctsp bctsp-jdk14.jar
	unbundle cdi-api
	unbundle commons-codec
	unbundle commons-collections
	unbundle commons-configuration
	unbundle commons-io-1 commons-io.jar
	unbundle commons-httpclient-3 httpclient.jar
	unbundle commons-lang-2.1 commons-lang.jar
	unbundle commons-lang-3.3 commons-lang3.jar
	unbundle commons-logging
	unbundle fontbox-1.7 fontbox.jar
	unbundle guava-13 guava.jar
	unbundle groovy groovy-all.jar
	unbundle itext
	unbundle jamon-2 jamonapi.jar
	unbundle javax-inject javax.inject.jar
	unbundle jboss-logging
	unbundle jdom
	unbundle jsr173 jsr173_api.jar
	unbundle jsr305
	unbundle logback logback-{core,classic}.jar
	unbundle javax-mail mail.jar
	unbundle lucene-1 lucene.jar
	unbundle pdfbox-1.8 pdfbox.jar

	#unbundle swt-4.2 native/swt_{32,64}.jar
	case $(tc-arch) in
		x86) dojar_and_rm native/swt_32.jar;;
		amd64) dojar_and_rm native/swt_64.jar;;
	esac

	dojar_and_rm dvb*.jar "${PN}-${MY_PV}.jar"

	for f in *.jar
	do
		debug-print "unable to unbundle ${f}"
	done
	java-pkg_dojar *.jar

	java-pkg_dolauncher "${PN}" --main ch.dvbern.lib.update.Launcher --pwd "${DATADIR}"
}
