#!/sbin/runscript
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

command="/usr/bin/${SVCNAME}.sh"
command_args="/etc/conf.d/${SVCNAME} --on-changes"
pidfile="/var/run/${SVCNAME}.pid"

depend() {
	use net
}
