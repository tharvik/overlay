#!/bin/sh

set -eux

readonly PACKAGE="${1}"

cd "/overlay/${PACKAGE}"

repoman full

if ! emerge -p "${PACKAGE}"
then
	emerge --autounmask-write "${PACKAGE}" || :

	find '/etc/portage' -name '._cfg*' | while read l
	do
		dirname="$(dirname "${l}")"
		filename="$(basename "${l}" | cut -d _ -f 3-)"

		mv "${l}" "${dirname}/${filename}"
	done
fi

emerge "${PACKAGE}"
