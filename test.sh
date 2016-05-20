#!/bin/sh

set -eux

readonly PACKAGE="${1}"

cd "/overlay/${PACKAGE}"

repoman full

emerge-accept --onlydeps "${PACKAGE}"
emerge-accept --verbose --jobs=1 "${PACKAGE}"
