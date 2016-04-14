#!/bin/sh

set -eux

find * -maxdepth 1 -type d | grep / | while read l
do
	grep -qF "PACKAGE=${l}" .travis.yml
done
