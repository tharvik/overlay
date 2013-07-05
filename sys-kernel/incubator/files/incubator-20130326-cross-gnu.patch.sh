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


# There are several parts marked with `TODO' in this file; feel free to have a
# look at these issues and send the outcome back to me.


# Functions from Paul Jarc's prjlibs available at
# <http://code.dogmap.org/prjlibs/>.

# sh/set_default.sh
case $? in 0) :;; *) (exit "$?");; esac &&
prj_set_default() {
  : "${2?}" &&
  eval "
  if test \"\${$1+x}\" = x; then :; else
    $1=\$2
  fi"
}


# Check for `cross-gnu-env' having been ran.

if [ x"${CROSS_GNU_REINSTALL_GLIBC-not_set}" = xnot_set ]; then
  cat >&2 <<"EOT" &&
See <http://www.gnu.org/software/hurd/toolchain/cross-gnu.html> for usage
information.
EOT
  exit 100
EOF
else :
fi &&


# Be verbose.

set -x &&


# Run-time configuration.

if test -f "$GLIBC_SRC"/elf/static-stubs.c; then
  prj_set_default GLIBC_have_static_stubs true
else
  prj_set_default GLIBC_have_static_stubs false
fi &&


# Create directories.

mkdir -p "$ROOT" &&
cd "$ROOT" &&
# TODO.  Are all these needed?
mkdir -p \
  bin \
  "$SYS_ROOT""$CROSS_GNU_USR"/include \
  "$SYS_ROOT""$CROSS_GNU_USR"/lib \
  "$TARGET" &&
# TODO.  Use relative links.
ln -sfn \
  "$SYS_ROOT""$CROSS_GNU_USR"/include \
  "$SYS_ROOT""$CROSS_GNU_USR"/lib \
  "$TARGET"/ &&

mkdir "$SYS_ROOT"/include &&


# Install the cross GNU Binutils.

mkdir -p "$BINUTILS_OBJ" &&
cd "$BINUTILS_OBJ"/ &&
# We use `config.status''s existence as an indicator whether the package was
# configured already.  (E.g. when running cross-gnu a second time to update the
# tool chain.)  Force the use of .init_array/.fini_array sections until
# auto-detection has been fixed.
if ./config.status --version > /dev/null 2>&1; then :; else
  "$BINUTILS_SRC"/configure \
    --target="$TARGET" \
    --prefix="$ROOT" \
    --with-sysroot="$SYS_ROOT" \
    --disable-nls \
    --enable-initfini-array
fi &&
"$MAKE" \
  all \
  install &&


# Install a minimal cross GCC to build a cross MIG and the GNU C Library.

mkdir -p "$GCC_OBJ" &&
cd "$GCC_OBJ"/ &&
# Perhaps we already have a complete cross GCC?
if "$TARGET"-gcc --version > /dev/null 2>&1; then :; else
  if ./config.status --version > /dev/null 2>&1; then :; else
    # TODO.  Why ``--with-newlib''?
    # TODO.  Decimal float support (``--disable-decimal-float'') is manually
    # deactivated, as there is no fenv.h yet (glibc), and there is no autoconf
    # test for its presence.
    "$GCC_SRC"/configure \
      --enable-build-with-cxx \
      --target="$TARGET" \
      --prefix="$ROOT" \
      --with-sysroot="$SYS_ROOT" \
      --disable-nls \
      --disable-shared \
      --disable-threads \
      --without-headers \
      --with-newlib \
      --disable-decimal-float \
      --enable-languages=c \
      --with-arch=i686
  fi &&

# TODO: GCC 3.3 and GCC 3.4 need this for building libgcc.a.  Not needed for
# GCC 4.0.  Get rid of this?
  : > "$SYS_ROOT""$CROSS_GNU_USR"/include/signal.h &&
  mkdir -p "$SYS_ROOT""$CROSS_GNU_USR"/include/sys &&
  : > "$SYS_ROOT""$CROSS_GNU_USR"/include/sys/ucontext.h &&

  if "$MAKE" \
      all-gcc \
      install-gcc &&
    if ! test -d "$GCC_SRC"/libgcc/; then :; else
      # libgcc is new with GCC 4.3.
      "$MAKE" \
	all-target-libgcc \
	install-target-libgcc
    fi &&
    if ! $GLIBC_have_static_stubs; then
# TODO: Make glibc happy.  We can not yet build libgcc_eh, but glibc's build
# system wants to link against that library.
# <http://sources.redhat.com/ml/libc-alpha/2003-09/msg00100.html>.  With
# $GLIBC_have_static_stubs, this is no longer necessary, as per
# id:"87txyoksdr.fsf@schwinge.name".
      echo '/* Empty.  */' > "$SYS_ROOT""$CROSS_GNU_USR"/lib/libgcc_eh.a
    fi
  then
    mv config.status config.status.removed &&
    # TODO.
    rm -f config.cache */config.cache */*/config.cache &&
    # Remove the bogus files if building the cross compiler succeeded.
    rm \
      "$SYS_ROOT""$CROSS_GNU_USR"/include/signal.h \
      "$SYS_ROOT""$CROSS_GNU_USR"/include/sys/ucontext.h
  else
    # That indication file might already have been installed, but we do not yet
    # have a complete, working cross compiler.
    rm -f "$ROOT"/bin/"$TARGET"-gcc &&
    exit 100
  fi
fi &&


# Install GNU Mach's header files.

mkdir -p "$GNUMACH_OBJ" &&
cd "$GNUMACH_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  # `$TARGET-gcc' doesn't work yet (to satisfy the Autoconf checks), but isn't
  # needed either.
  CC=gcc \
  "$GNUMACH_SRC"/configure \
    --host="$TARGET" \
    --prefix="$CROSS_GNU_USR"
fi &&
"$MAKE" \
  DESTDIR="$SYS_ROOT" \
  install-data &&


# Install a cross GNU MIG.

mkdir -p "$MIG_OBJ" &&
cd "$MIG_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  "$MIG_SRC"/configure \
    --target="$TARGET" \
    --prefix="$ROOT"
fi &&
"$MAKE" \
  all \
  install &&


# Install the GNU Hurd's core libraries' header files.

mkdir -p "$HURD_OBJ" &&
cd "$HURD_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  # `$TARGET-gcc' doesn't work yet (to satisfy the Autoconf checks), but isn't
  # needed either.
  CC=gcc \
  "$HURD_SRC"/configure \
    --host="$TARGET" \
    --prefix="$CROSS_GNU_USR" \
    --disable-profile \
    --without-parted
fi &&
"$MAKE" \
  prefix="$SYS_ROOT""$CROSS_GNU_USR" \
  no_deps=t \
  install-headers &&
# Below, we will reconfigure for allowing to build libpthread.
if grep -q '^CC = gcc$' config.make
then rm config.status
else :
fi &&

mkdir -p "$LIBPTHREAD_OBJ" &&
cd "$LIBPTHREAD_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  # `$TARGET-gcc' doesn't work yet (to satisfy the Autoconf checks), but isn't
  # needed either.
  CC=gcc \
  "$LIBPTHREAD_SRC"/configure \
    --host="$TARGET" \
    --prefix="$CROSS_GNU_USR" \
    ac_cv_lib_ihash_hurd_ihash_create=yes
fi &&
"$MAKE" \
  DESTDIR="$SYS_ROOT" \
  install-data-local-headers &&
# Below, we will reconfigure for allowing to build libpthread.
if grep -q '^CC = gcc$' Makefile
then rm config.status
else :
fi &&


# Install the GNU C Library.

# Do we already have the GNU C library installed?
if test -h "$SYS_ROOT"/lib/ld.so; then :; else
  mkdir -p "$GLIBC_OBJ" &&
  cd "$GLIBC_OBJ"/ &&
  if ./config.status --version > /dev/null 2>&1; then :; else
    # `--build' has to be set to make sure that glibc is cross compiled.
    # TODO: --disable-multi-arch
    "$GLIBC_SRC"/configure \
      AUTOCONF=: \
      --without-cvs \
      --build="$("$GLIBC_SRC"/scripts/config.guess)" \
      --host="$TARGET" \
      --prefix="$CROSS_GNU_USR" \
      --with-headers="$SYS_ROOT""$CROSS_GNU_USR"/include \
      --disable-profile \
      --disable-multi-arch
  fi &&
  # Set an invalid/obfuscated install_root in order to work around the
  # ``/usr/include/pthread.h overwrite issue''; see open_issues/glibc.
  if "$MAKE" \
       install_root=/INVALID \
       all &&
     "$MAKE" \
       install_root=/"$SYS_ROOT" \
       install
  then
    # TODO: Why doesn't `make install' do that?
    ln -sf ld.so.1 "$SYS_ROOT"/lib/ld.so &&
    if [ "$CROSS_GNU_REINSTALL_GLIBC" = n ]; then :; else
      # Force re-linking files once libgcc and libgcc_eh are available.  TODO: Is the
      # following enough?
      rm -f "$GLIBC_OBJ"/config.status
#      rm -rf "$GLIBC_OBJ"
    fi
  else
    # That indication file might already have been installed, but we do not yet
    # have a complete, working installation of the GNU C library.
    rm -f "$SYS_ROOT"/lib/ld.so
    exit 100
  fi
fi &&


# Install the GNU Hurd's core libraries.

cd "$HURD_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  "$HURD_SRC"/configure \
    --host="$TARGET" \
    --prefix="$CROSS_GNU_USR" \
    --disable-profile \
    --without-parted
fi &&
"$MAKE" \
  libihash &&
"$MAKE" \
  prefix="$SYS_ROOT""$CROSS_GNU_USR" \
  libihash-install &&

mkdir -p "$LIBPTHREAD_OBJ" &&
cd "$LIBPTHREAD_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  "$LIBPTHREAD_SRC"/configure \
    --host="$TARGET" \
    --prefix="$CROSS_GNU_USR"
fi &&
"$MAKE" \
  all &&
"$MAKE" \
  DESTDIR="$SYS_ROOT" \
  install &&


# Install a complete cross GCC.

cd "$GCC_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  # TODO: At the moment we only configure for creating a C compiler.
  # GCC 4.1 (and also the newer ones without patching) don't default to
  # enabling threading support for `$TARGET', thus ``--enable-threads=posix''
  # is given.
  "$GCC_SRC"/configure \
    --enable-build-with-cxx \
    --target="$TARGET" \
    --prefix="$ROOT" \
    --with-sysroot="$SYS_ROOT" \
    --disable-nls \
    --enable-threads=posix \
    --enable-languages=c,c++ \
    --with-arch=i686
fi &&
if [ x"$CROSS_GNU_USR" = x/usr ]; then :; else
  # ``The directory that should contain system headers does not exist:
  # $SYS_ROOT/usr/include''.
  mkdir -p "$SYS_ROOT"/usr/include
fi &&
"$MAKE" \
  all &&
if ! $GLIBC_have_static_stubs; then
# Remove the bogus libgcc_eh, libgcc and libgcov that may have been installed
# earlier.  TODO.  Why are libgcc.a and libgcov.a handled here?
  rm -f "$SYS_ROOT""$CROSS_GNU_USR"/lib/libgcc_eh.a \
    "$ROOT"/lib/gcc/"$TARGET"/*/libgcc.a "$ROOT"/lib/gcc/"$TARGET"/*/libgcov.a
fi &&
"$MAKE" \
  install &&


# Install the GNU C Library.

# TODO.  With $GLIBC_have_static_stubs, this may no longer be necessary, as per
# id:"87txyoksdr.fsf@schwinge.name".
mkdir -p "$GLIBC_OBJ" &&
cd "$GLIBC_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  # `--build' has to be set to make sure that glibc is cross compiled.
  # TODO: --disable-multi-arch
  "$GLIBC_SRC"/configure \
    AUTOCONF=: \
    --without-cvs \
    --build="$("$GLIBC_SRC"/scripts/config.guess)" \
    --host="$TARGET" \
    --prefix="$CROSS_GNU_USR" \
    --with-headers="$SYS_ROOT""$CROSS_GNU_USR"/include \
    --disable-profile \
    --disable-multi-arch
fi &&
# Set an invalid/obfuscated install_root in order to work around the
# ``/usr/include/pthread.h overwrite issue''; see open_issues/glibc.
"$MAKE" \
  install_root=/INVALID \
  all &&
"$MAKE" \
  install_root=/"$SYS_ROOT" \
  install &&


# Install a cross GDB, if requested.

if test -d "$GDB_SRC"/; then
  mkdir -p "$GDB_OBJ" &&
  cd "$GDB_OBJ"/ &&
  if ./config.status --version > /dev/null 2>&1; then :; else
    "$GDB_SRC"/configure \
      --target="$TARGET" \
      --prefix="$ROOT" \
      --with-sysroot="$SYS_ROOT" \
      --disable-nls
  fi &&
  "$MAKE" \
    all \
    install &&


  # If possible, install a cross compiled `gdbserver' to be ran on the TARGET
  # system.

  if grep -q '86-\*-gnu\*' "$GDB_SRC"/gdb/gdbserver/README; then
    mkdir -p gdb/gdbserver &&
    cd gdb/gdbserver &&
    if ./config.status --version > /dev/null 2>&1; then :; else
      "$GDB_SRC"/gdb/gdbserver/configure \
        --host="$TARGET" \
        --prefix="$SYS_ROOT"
    fi &&
    "$MAKE" \
      all \
      install
  else :
  fi
fi &&


# Install GNU Mach

cd "$GNUMACH_OBJ"/ &&
if ./config.status --version > /dev/null 2>&1; then :; else
  # `$TARGET-gcc' doesn't work yet (to satisfy the Autoconf checks), but isn't
  # needed either.
  CC=gcc \
  "$GNUMACH_SRC"/configure \
    --host="$TARGET" \
    --prefix="$CROSS_GNU_USR"
fi &&
"$MAKE" \
  DESTDIR="$SYS_ROOT" \
  install &&

# Success.

echo "$0"': Everything should be in place now.'
