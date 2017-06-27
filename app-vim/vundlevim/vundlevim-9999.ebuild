# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin git-r3

DESCRIPTION='vim plugin: plugin manager'
HOMEPAGE='http://www.vim.org/scripts/script.php?script_id=3458'
LICENSE='MIT'
KEYWORDS=''
IUSE=''

EGIT_REPO_URI='https://github.com/VundleVim/Vundle.vim.git'

VIM_PLUGIN_HELPFILES='doc/vundle.txt'
VIM_PLUGIN_HELPTEXT=''
VIM_PLUGIN_HELPURI=''
VIM_PLUGIN_MESSAGES=''

src_prepare()
{
	default

	rm -r test || die 'unable to remove tests'
}
