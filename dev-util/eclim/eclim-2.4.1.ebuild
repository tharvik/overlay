# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vim-plugin java-pkg-2 java-ant-2

MY_P="${PN}_${PV}"

DESCRIPTION="Brings Eclipse functionality to Vim"
HOMEPAGE="http://eclim.org/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-editors/vim
	|| (
		dev-util/eclipse-sdk
		dev-util/eclipse-sdk-bin
	)

	dev-java/ant
	dev-java/nailgun
	dev-python/sphinx
	dev-util/eclipse-sdk-bin:4.4
	virtual/jdk:1.7
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
ECLIPSE_PATH="${D}/opt/eclipse-sdk-bin-4.4/"
ECLIPSE_INSTALL_PATH="${ROOT}/opt/eclipse-sdk-bin-4.4/"
VIM_PATH="${D}/usr/share/vim/vimfiles"

src_prepare()
{
	# fix build, thanks to mikezackles
	sed -e 's|${user.home}/\.|${vim.files}/|g' \
	-e "s|File(getVariable('eclipse')|File('${ECLIPSE_PATH}'|g" \
	-e "s|getVariable('env.FAKEROOTKEY') == null)|false)|" \
	-e '68,88d' \
	-i ant/build.gant

	chmod +x org.eclim/nailgun/configure bin/sphinx

	java-ant-2_src_configure
}

src_compile()
{
	mkdir -p "${VIM_PATH}"
	mkdir -p "${D}/opt"
	cp -r "${ECLIPSE_INSTALL_PATH}" "${ECLIPSE_PATH}" || die

	ant -Declipse.home="${ECLIPSE_PATH}" eclipse.init || die

	ant -Declipse.home="${ECLIPSE_PATH}" \
		-Dvim.files="${VIM_PATH}" \
		build || die
}

src_install()
{
	mkdir -p "${VIM_PATH}"
	mkdir -p "${D}/opt"
	cp -r "${ECLIPSE_INSTALL_PATH}" "${ECLIPSE_PATH}" || die

	ant -Declipse.home="${ECLIPSE_PATH}" eclipse.init || die

	ant -Declipse.home="${ECLIPSE_PATH}" \
		-Dvim.files="${VIM_PATH}" \
		build || die

	#ant -Declipse.home="${ECLIPSE_PATH}" \
		#-Dvim.files="${VIM_PATH}" \
		#docs vimdocs || die

	ant -Declipse.home="${ECLIPSE_PATH}" \
		-Dvim.files="${VIM_PATH}" \
		deploy || die

	set -x
	find "${ECLIPSE_INSTALL_PATH}" -type f | while read f
	do
		[ -e "${D}/${f}" ] && rm "${D}/${f}"
	done

	# copy eclim docs
	#dodoc -r build/doc/site

	# fix eclim paths
	sed -e "s|${D}||g" \
		-i "${VIM_PATH}/${PN}/plugin/${PN}" \
		-i "${ECLIPSE_PATH}/plugins/org.${MY_P}/bin/eclimd" \
		-i "${ECLIPSE_PATH}}/plugins/org.${MY_P}/plugin.properties"

	# delete doctrees
	#rm -fr "${D}/usr/share/doc/eclim/.doctrees"

	# delete Windows stuff
	#for i in $(find "${D}" -regex ".*bat\|.*cmd\|.*exe"); do rm -f $i ; done

	#rm "${D}/usr/share/eclipse/plugins/org.eclim_${PV}/nailgun/config.status"
}
