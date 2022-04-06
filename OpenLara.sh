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

GAMEDIR="/$directory/ports/tombraider1"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib"

$ESUDO rm -rf ~/.openlara
$ESUDO ln -s $GAMEDIR/conf/.openlara/ ~/
cd $GAMEDIR

$ESUDO chmod 666 /dev/uinput
$ESUDO ./oga_controls OpenLara $param_device &
./OpenLara 2>&1 | tee ./log.txt
$ESUDO kill -9 $(pidof oga_controls)
$ESUDO systemctl restart oga_events &
unset LD_LIBRARY_PATH
printf "\033c" >> /dev/tty1
