#!/bin/bash

if [[ -e "/dev/input/by-path/platform-ff300000.usb-usb-0:1.2:1.0-event-joystick" ]]; then
  param_device="anbernic"
elif [[ -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
    if [[ ! -z $(cat /etc/emulationstation/es_input.cfg | grep "190000004b4800000010000001010000") ]]; then
	  param_device="oga"
	else
	  param_device="rk2020"
	fi
elif [[ -e "/dev/input/by-path/platform-odroidgo3-joypad-event-joystick" ]]; then
  param_device="ogs"
else
  param_device="chi"
fi

sudo chmod 666 /dev/tty1

if [ -f "/opt/system/Advanced/Switch to main SD for Roms.sh" ]; then
  directory="roms2"
else
  directory="roms"
fi

export SDL_GAMECONTROLLERCONFIG="$(cat /$directory/ports/sdlpop/gamecontrollerdb.txt)"
cd /$directory/ports/sdlpop
sudo ./oga_controls prince $param_device &
./prince
unset SDL_GAMECONTROLLERCONFIG
sudo kill -9 $(pidof oga_controls)
sudo systemctl restart oga_events &
printf "\033c" > /dev/tty1