#!/bin/bash

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt

get_controls

$ESUDO chmod 666 /dev/tty1

export LD_LIBRARY_PATH=/$directory/ports/am2r/libs:/usr/lib:/usr/lib32
$ESUDO rm -rf ~/.config/am2r
ln -sfv /$directory/ports/am2r/conf/am2r/ ~/.config/
cd /$directory/ports/am2r
$ESUDO ./oga_controls gmloader $param_device &
./gmloader gamedata/am2r.apk
$ESUDO kill -9 $(pidof oga_controls)
unset LD_LIBRARY_PATH
$ESUDO systemctl restart oga_events &
printf "\033c" > /dev/tty1