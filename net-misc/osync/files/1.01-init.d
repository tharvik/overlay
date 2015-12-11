#!/sbin/runscript
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

CONFDIR="/etc/${SVCNAME}"
PIDPREFIX="/var/run/${SVCNAME}-"
command="/usr/bin/${SVCNAME}.sh"

depend() {
	use net
}

start() {
	ebegin "Starting ${SVCNAME}"

	local ret=0

	for f in "${CONFDIR}"/*.conf
	do
		start-stop-daemon --start --quiet --exec "${command}"	\
			--pidfile "${PIDPREFIX}${f}.pid" \
			-- "${f}" --on-changes
		ret=$((ret | $?))
	done

	eend $ret
}

stop() {
	ebegin "Stoping ${SVCNAME}"

	local ret=0

	for f in "${PIDPREFIX}"*
	do
		start-stop-daemon --stop --quiet --pidfile "${f}"
		ret=$((ret | $?))
	done

	eend $ret
}
