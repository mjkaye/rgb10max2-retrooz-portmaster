#!/bin/bash

whichos=$(grep "title=" "/usr/share/plymouth/themes/text.plymouth")
if [[ $whichos == *"TheRA"* || $whichos == *"RetroOZ"* ]]; then
  raloc="/opt/retroarch/bin"
elif [[ -e "/storage/.config/.OS_ARCH" ]]; then
  raloc="/usr/bin"
else
  raloc="/usr/local/bin"
fi

if [ -f "/opt/system/Advanced/Switch to main SD for Roms.sh" ]; then
  GAMEDIR="/roms2/ports/2048"
else
  GAMEDIR="/roms/ports/2048"
fi

$raloc/retroarch -L $GAMEDIR/2048_libretro.so
