################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
#      Copyright (C) 2016 kszaq
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libhybris"
PKG_VERSION="54dd474"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libhybris/libhybris/"
PKG_URL="none"
PKG_DEPENDS_TARGET="toolchain android-headers"
PKG_SECTION="devel"
PKG_SHORTDESC="libhybris: Allows to run bionic-based HW adaptations in glibc systems - libs"
PKG_LONGDESC="libhybris: Allows to run bionic-based HW adaptations in glibc systems - libs."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

unpack() {
  mkdir -p $PKG_BUILD
  git clone -b 'master' https://github.com/libhybris/libhybris.git $PKG_BUILD/src-temp
  cd $PKG_BUILD/src-temp
  git reset --hard $PKG_VERSION
  cd ..
  cp -PR src-temp/hybris/* ./
  rm -rf src-temp
  cd $ROOT
}

PKG_CONFIGURE_OPTS_TARGET="--enable-arch=$TARGET_ARCH \
                           --with-default-egl-platform=fbdev \
                           --with-android-headers=$BUILD/android-headers-25 \
                           --with-default-hybris-ld-library-path=/system/lib \
                           --enable-mali-quirks"
