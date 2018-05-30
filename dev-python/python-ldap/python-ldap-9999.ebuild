# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6} pypy )

inherit distutils-r1 git-r3

DESCRIPTION='Various LDAP-related Python modules'
HOMEPAGE='https://www.python-ldap.org/en/latest/ https://pypi.org/project/python-ldap/'
EGIT_REPO_URI='https://github.com/python-ldap/python-ldap.git'

LICENSE='PSF-2'
SLOT='0'
IUSE='sasl ssl'

RDEPEND="
	>=dev-python/pyasn1-0.3.7[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.1.5[${PYTHON_USEDEP}]

	>=net-nds/openldap-2.4.11
	ssl? ( dev-libs/openssl )
	sasl? ( dev-libs/cyrus-sasl:2 )
"
DEPEND="${RDEPEND}"

python_prepare_all() {
	library_dirs="/usr/$(get_libdir)"
	include_dirs='/usr/include'
	libs='ldap_r lber'

	if use ssl
	then
		libs+=' ssl crypto'
	fi

	if use sasl
	then
		library_dirs+="/usr/$(get_libdir)/sasl2"
		libs+=' sasl2'
	fi

	cat > setup.cfg <<-EOF
	[_ldap]
	library_dirs = ${library_dirs}
	include_dirs = ${include_dirs}

	libs = ${libs}
	EOF

	distutils-r1_python_prepare_all
}
