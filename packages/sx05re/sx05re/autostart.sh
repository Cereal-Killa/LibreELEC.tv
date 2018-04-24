#!/bin/sh
# USB roms 
sleep 2

# Clean cache garbage when boot up.
rm -rf /storage/.cache/cores/*

/usr/bin/setres.sh
SPLASH="/storage/.config/splash/splash-1080.png"
(
  fbi $SPLASH -noverbose > /dev/null 2>&1
)&

# End of reading the video output mode and setting it for sx05re to avoid video flicking.
# The codes can be simplified with "elseif" sentences.
# The codes for 480I and 576I are adjusted to avoid overscan.
# Forece 720p50hz to 720p60hz and 1080i/p60hz to 1080i/p60hz since 50hz would make video very choppy.

#since the ROMS folder is not getting created at boot, we check if it exists, if it doesn't then we create it. 
if [ ! -d "/storage/roms" ] || [ ! -d "/storage/roms2" ]; then
  mkdir /storage/roms
  mkdir /storage/roms/atari2600
  mkdir /storage/roms/atari5200
  mkdir /storage/roms/atari7800
  mkdir /storage/roms/atarilynx
  mkdir /storage/roms/c64
  mkdir /storage/roms/dreamcast
  mkdir /storage/roms/fba
  mkdir /storage/roms/fds
  mkdir /storage/roms/gamegear
  mkdir /storage/roms/gb
  mkdir /storage/roms/gba
  mkdir /storage/roms/gbc
  mkdir /storage/roms/mame
  mkdir /storage/roms/mame-advmame
  mkdir /storage/roms/mastersystem
  mkdir /storage/roms/megadrive
  mkdir /storage/roms/msx
  mkdir /storage/roms/n64
  mkdir /storage/roms/neogeo
  mkdir /storage/roms/nes
  mkdir /storage/roms/pc
  mkdir /storage/roms/pcengine
  mkdir /storage/roms/psp
  mkdir /storage/roms/psx
  mkdir /storage/roms/scummvm
  mkdir /storage/roms/sega32x
  mkdir /storage/roms/segacd
  mkdir /storage/roms/snes
  mkdir /storage/roms/videopac
  mkdir /storage/roms/zxspectrum
fi

#name of the file we need to put in the roms folder in your USB or SDCARD 
ROMFILE="scottelecroms"

# we look for the file in the rompath
FULLPATHTOROMS="$(find /media/*/roms/ -name $ROMFILE -maxdepth 1)"

if [[ -z "${FULLPATHTOROMS}" ]]; then
# echo "can't find roms"

    if [ -L /storage/roms ]; then
      rm /storage/roms
      mv /storage/roms2 /storage/roms
 fi
    else
      mv /storage/roms /storage/roms2
      #echo "move the roms folder"
 
       # we strip the name of the file.
       PATHTOROMS=${FULLPATHTOROMS%$ROMFILE}

       #we create the symlink to the roms in our USB
       ln -sf $PATHTOROMS /storage/roms
 fi

#set reicast BIOS dir to point to /storage/roms/bios
if [ ! -L /storage/.local/share/reicast/data ]; then
	mkdir -p /storage/.local/share/reicast 
	rm -rf /storage/.local/share/reicast/data
	ln -s /storage/roms/bios /storage/.local/share/reicast/data
fi

#hacky way to get samba on boot
/usr/lib/samba/samba-config
systemctl start smbd

if [ ! -f /storage/.emulationstation/es_settings.cfg ]; then
   cp /usr/config/emulationstation/es_settings.cfg /storage/.emulationstation/es_settings.cfg
fi

DEFE=$(sed -n 's|\s*<string name="Sx05RE_BOOT" value="\(.*\)" />|\1|p' /storage/.emulationstation/es_settings.cfg)

case "$DEFE" in
*)
	rm -rf /var/lock/start.retro
	rm -rf /var/lock/start.games
	touch  /var/lock/start.kodi
	;;
"Retroarch")
	rm -rf /var/lock/start.kodi
	rm -rf /var/lock/start.games
	touch /var/lock/start.retro
	systemctl start retroarch
	;;
"EmulationStation")
	rm -rf /var/lock/start.kodi
	rm -rf /var/lock/start.retro
	/usr/bin/startfe.sh &
	;;
esac
