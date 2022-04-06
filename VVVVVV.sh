#!/bin/bash

ESUDO="sudo"
if [ -f "/storage/.config/.OS_ARCH" ]; then
  ESUDO=""
fi

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

if [ -f "/opt/system/Advanced/Switch to main SD for Roms.sh" ]; then
  GAMEDIR="/roms2/ports/VVVVVV"
else
  GAMEDIR="/roms/ports/VVVVVV"
fi

cd $GAMEDIR

rm -rf ~/.local/share/VVVVVV
ln -s /$GAMEDIR ~/.local/share/
$ESUDO ./oga_controls VVVVVV $param_device &
./VVVVVV
$ESUDO kill -9 $(pidof oga_controls)
$ESUDO systemctl restart oga_events &
printf "\033c" >> /dev/tty1