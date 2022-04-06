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

GAMEDIR=/$directory/ports/RigelEngine
cd $GAMEDIR
$ESUDO chmod 666 /dev/uinput
$GPTOKEYB "RigelEngine" &
SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig" ./RigelEngine 2>&1 | tee ./log.txt
sudo kill -9 $(pidof oga_controls)
sudo systemctl restart oga_events &
printf "\033c" >> /dev/tty1
