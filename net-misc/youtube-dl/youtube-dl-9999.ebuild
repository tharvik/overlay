# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=(python{2_6,2_7,3_3,3_4})
DISTUTILS_SINGLE_IMPL=true
inherit bash-completion-r1 distutils-r1 eutils
[[ ${PV} == 9999 ]] && inherit git-2

DESCRIPTION="Download videos from YouTube.com (and mores sites...)"
HOMEPAGE="http://rg3.github.com/youtube-dl/"
if [ ${PV} == 9999 ]
then
	SRC_URI=''
	EGIT_REPO_URI='git://github.com/rg3/youtube-dl.git'
	KEYWORDS=''
else
	SRC_URI="http://youtube-dl.org/downloads/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
fi

LICENSE="public-domain"
SLOT="0"
IUSE="offensive test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	app-text/pandoc
	test? ( dev-python/nose[coverage(+)] )
"

S="${WORKDIR}/${PN}"

src_prepare() {
	if ! use offensive; then
		sed -i -e "/__version__/s|'$|-gentoo_no_offensive_sites'|g" \
			youtube_dl/version.py || die
		local xxx=(
			extremetube fourtube goshgay hentaistigma mofosex pornhd pornhub
			pornotube redtube slutload spankwire thisav trutube tube8 xbef
			xhamster xnxx xtube xvideos youjizz youporn
		)
		sed -i -e $( printf '/%s/d;' ${xxx[@]} ) youtube_dl/extractor/__init__.py || die
		rm $( printf 'youtube_dl/extractor/%s.py ' ${xxx[@]} ) \
			test/test_age_restriction.py || die
	fi

	cp README.md README.txt
}

src_compile() {
	emake youtube-dl.1 bash-completion
	distutils-r1_src_compile
}

src_test() {
	emake test
}

src_install() {
	python_domodule youtube_dl
	dobin bin/${PN}
	dodoc README.txt
	doman ${PN}.1
	newbashcomp ${PN}.bash-completion ${PN}
	python_fix_shebang "${ED}"
}
