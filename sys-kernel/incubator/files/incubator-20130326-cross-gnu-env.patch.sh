#!/bin/sh

# Cross compile a GNU build environment,
# <http://www.gnu.org/software/hurd/toolchain/cross-gnu.html>.

# Copyright (C) 2006, 2007, 2008, 2010, 2011, 2012 Free Software Foundation,
# Inc.

# Written by Thomas Schwinge <thomas@schwinge.name>.

# This file is part of the GNU Hurd.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Functions from Paul Jarc's prjlibs available at
# <http://code.dogmap.org/prjlibs/>.

# sh/set.sh
case $? in 0) :;; *) (exit "$?");; esac &&
prj_set() {
  eval "$1=\${2?}"
}

# sh/set_default.sh
case $? in 0) :;; *) (exit "$?");; esac &&
prj_set_default() {
  : "${2?}" &&
  eval "
  if test \"\${$1+x}\" = x; then :; else
    $1=\$2
  fi"
}

# sh/unset.sh
case $? in 0) :;; *) (exit "$?");; esac &&
prj_unset() {
  while test "$#" != 0; do
    { eval "$1=" &&
      unset "$1" &&
      shift
    } || return "$?"
  done
}

# sh/x2.sh
case $? in 0) :;; *) (exit "$?");; esac &&
prj_x2() {
  : "${2?}" &&
  "$@" &&
  export "$2"
}

case $? in 0) :;; *) (exit "$?");; esac &&


# Create a clean environment.

prj_x2 prj_set LC_ALL C &&
prj_unset ASFLAGS CFLAGS CPPFLAGS CXXFLAGS LDFLAGS &&
prj_unset MAKEFLAGS &&


# Environment variables.

# `$ROOT' defaults to `~/tmp/gnu'.
prj_x2 prj_set_default ROOT ~/tmp/gnu &&
# `$ROOT' must specify an absolute path.
case $ROOT in
  /*)
    :;;
  *)
    ROOT=`cd "$ROOT" && pwd`;;
esac &&

prj_x2 prj_set_default SYS_ROOT "$ROOT"/sys_root &&

# Note that to avoid confusing GCC, the following has to match how GCC is
# configured re NATIVE_SYSTEM_HEADER_DIR (gcc/config/t-gnu) or
# native_system_header_dir (gcc/config.gcc) or the
# --with-native-system-header-dir command-line option.
#prj_unset CROSS_GNU_USR &&
prj_x2 prj_set_default CROSS_GNU_USR /usr &&

prj_x2 prj_set_default TARGET i686-pc-gnu &&

prj_x2 prj_set_default BINUTILS_SRC "$ROOT"/src/binutils &&
prj_x2 prj_set_default BINUTILS_OBJ "$ROOT"/obj/binutils &&
prj_x2 prj_set_default GCC_SRC "$ROOT"/src/gcc &&
prj_x2 prj_set_default GCC_OBJ "$ROOT"/obj/gcc &&
prj_x2 prj_set_default GDB_SRC "$ROOT"/src/gdb &&
prj_x2 prj_set_default GDB_OBJ "$ROOT"/obj/gdb &&
prj_x2 prj_set_default GLIBC_SRC "$ROOT"/src/glibc &&
prj_x2 prj_set_default GLIBC_OBJ "$ROOT"/obj/glibc &&
prj_x2 prj_set_default GNUMACH_SRC "$ROOT"/src/gnumach &&
prj_x2 prj_set_default GNUMACH_OBJ "$ROOT"/obj/gnumach &&
prj_x2 prj_set_default HURD_SRC "$ROOT"/src/hurd &&
prj_x2 prj_set_default HURD_OBJ "$ROOT"/obj/hurd &&
prj_x2 prj_set_default MIG_SRC "$ROOT"/src/mig &&
prj_x2 prj_set_default MIG_OBJ "$ROOT"/obj/mig &&
prj_x2 prj_set_default LIBPTHREAD_SRC "$ROOT"/src/libpthread &&
prj_x2 prj_set_default LIBPTHREAD_OBJ "$ROOT"/obj/libpthread &&

# TODO.  See cross-gnu.
prj_x2 prj_set_default CROSS_GNU_REINSTALL_GLIBC y &&

prj_x2 prj_set PATH "$ROOT"/bin:"$PATH" &&

prj_x2 prj_set MAKE emake

# See GNU Mach's `Makefile.am' for why.  This is for the packages that don't
# handle it themselves.
prj_x2 prj_set INSTALL "$GNUMACH_SRC"/build-aux/install-sh\ -C
