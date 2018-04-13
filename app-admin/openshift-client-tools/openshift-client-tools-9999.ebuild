# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1 git-r3

DESCRIPTION="Enterprise Kubernetes for Developers (Client Tools)"
HOMEPAGE="https://www.openshift.org"
SRC_URI=''
EGIT_REPO_URI='https://github.com/openshift/origin.git'

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="bash-completion zsh-completion kerberos"

DEPEND="dev-lang/go
	kerberos? ( app-crypt/mit-krb5 )"
RDEPEND="bash-completion? ( >=app-shells/bash-completion-2.3-r1 )"

src_prepare() {
		default

		if use zsh-completion
		then
			sed -i '1a #compdef oc' contrib/completions/zsh/oc || \
				die 'unable to fix zsh completion'
		fi
}

src_compile() {
	use kerberos && MY_TAGS="-tags=gssapi"

	local commit="$(git rev-parse HEAD)"
	export OS_GIT_COMMIT="$version" OS_GIT_VERSION="$version"
	export KUBE_GIT_COMMIT KUBE_GIT_VERSION

	emake all WHAT="cmd/oc ${MY_TAGS} -v"

	emake all WHAT="tools/gendocs -v"
	emake all WHAT="tools/genman -v"
	hack/generate-docs.sh || exit 1
}

src_install() {
	case "${ARCH}" in
		x86)	MY_ARCH="386" ;;
		*)		MY_ARCH="${ARCH}" ;;
	esac

	dobin "_output/local/bin/linux/${MY_ARCH}/oc"
	doman docs/man/man1/oc*
	use bash-completion && dobashcomp contrib/completions/bash/oc

	if use zsh-completion
	then
		insinto /usr/share/zsh/site-functions
		newins contrib/completions/zsh/oc _oc
	fi
}
