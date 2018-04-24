################################################################################
#      This file is part of sx05re
#      no copyright, do as you please :)
################################################################################

PKG_NAME="sx05re"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="retroarch-sx05re $LIBRETRO_CORES"
PKG_SECTION="sx05re"
PKG_SHORTDESC="Sx05re Meta Package"
PKG_LONGDESC="Sx05re Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# Thanks to magicseb  Reicast SA now WORKS :D
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vba-next libretro-beetle-pce-fast advancemame PPSSPPSDL reicastsa common-shaders scraper sx05re_frontend fbida mame2003-plus-libretro"

 
# You can build some less used Libretro cores by using $LIBRETRO_EXTRA_CORES but you might run into size problems.
#PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $LIBRETRO_EXTRA_CORES mame2010 mame2014"


make_target() {
  : not
}

makeinstall_target() {
   
  mkdir -p $INSTALL/etc/samba
   cp $PKG_DIR/config/smb.conf $INSTALL/etc/samba

  mkdir -p $INSTALL/usr/config/
    cp -rf $PKG_DIR/config/* $INSTALL/usr/config/
    cp $PKG_DIR/autostart.sh $INSTALL/usr/config/autostart.sh
 
  mkdir -p $INSTALL/usr/bin/
    cp $PKG_DIR/bin/* $INSTALL/usr/bin/
    chmod +x $INSTALL/usr/bin/*

  mkdir -p $INSTALL/usr/share/kodi/addons/
    cp -rf $PKG_DIR/addon/* $INSTALL/usr/share/kodi/addons/

  mkdir -p $INSTALL/usr/share/retroarch-overlays
    cp -r $PKG_DIR/overlay/* $INSTALL/usr/share/retroarch-overlays
  
  mkdir -p $INSTALL/usr/share/common-shaders
    cp -r $PKG_DIR/shaders/* $INSTALL/usr/share/common-shaders
    
    mkdir -p $INSTALL/usr/share/libretro-database
     touch $INSTALL/usr/share/libretro-database/dummy

##this needs to be moved to filesystem, but I put it here for easy testing. 
  mkdir -p $INSTALL/usr/config/asound.conf
    cp $PKG_DIR/asound.conf/asound.conf $INSTALL/usr/config/asound.conf/asound.conf

}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    chmod +x $INSTALL/usr/bin/*

}
