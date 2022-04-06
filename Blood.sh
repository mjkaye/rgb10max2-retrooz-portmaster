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

GAMEDIR="/$directory/ports/Blood"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GAMEDIR/lib:/usr/lib"

GPTOKEYB_CONFIG="$GAMEDIR/nblood.gptk"

$ESUDO rm -rf ~/.config/nblood
$ESUDO ln -s $GAMEDIR/conf/nblood ~/.config/
cd $GAMEDIR

$ESUDO chmod 666 /dev/uinput
$ESUDO $controlfolder/oga_controls nblood $param_device &
./nblood 2>&1 | tee ./log.txt
$ESUDO kill -9 $(pidof oga_controls)
$ESUDO systemctl restart oga_events &
unset LD_LIBRARY_PATH
printf "\033c" >> /dev/tty1
