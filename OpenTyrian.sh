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

if [[ -e "/usr/share/plymouth/themes/text.plymouth" ]]; then
    plymouth="/usr/share/plymouth/themes/text.plymouth"
    temp=$(grep "title=" $plymouth)
fi

if [[ $temp == *"ArkOS"* ]]; then
  cp /home/ark/.asoundrcfords /home/ark/.asoundrc
fi

if [ -f "/opt/system/Advanced/Switch to main SD for Roms.sh" ]; then
  sudo rm -rf ~/.config/opentyrian
  ln -sfv /roms2/ports/opentyrian/ ~/.config/
  cd /roms2/ports/opentyrian
  sudo ./oga_controls opentyrian $param_device &
  /roms2/ports/opentyrian/opentyrian --data=/roms2/ports/opentyrian/data
else
  sudo rm -rf ~/.config/opentyrian
  cd /roms/ports/opentyrian
  sudo ./oga_controls opentyrian $param_device &
  ln -sfv /roms/ports/opentyrian/ ~/.config/
  /roms/ports/opentyrian/opentyrian --data=/roms/ports/opentyrian/data
fi

if [[ $temp == *"ArkOS"* ]]; then
  cp /home/ark/.asoundrcbak /home/ark/.asoundrc
fi

sudo kill -9 $(pidof oga_controls)
sudo systemctl restart oga_events &
printf "\033c" >> /dev/tty1
