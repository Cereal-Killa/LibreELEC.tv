import os
import xbmc, xbmcgui, xbmcaddon

dialog = xbmcgui.Dialog()
dialog.notification('RetroArch', 'Launching....', xbmcgui.NOTIFICATION_INFO, 5000)

xbmc.executebuiltin('System.Exec("/usr/bin/retroarch.sh")')
