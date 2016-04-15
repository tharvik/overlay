#!/bin/sh

set -eux

readonly PACKAGE="${1}"

cd "/overlay/${PACKAGE}"

repoman full

emerge-accept "${PACKAGE}"
