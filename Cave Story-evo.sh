#!/bin/bash

ESUDO="sudo"
if [ -f "/storage/.config/.OS_ARCH" ]; then
  ESUDO=""
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/storage/roms/ports/nxengine-evo/libs"
fi

if [[ -e "/dev/input/by-path/platform-ff300000.usb-usb-0:1.2:1.0-event-joystick" ]]; then
  param_device="anbernic"
elif [[ -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
    if [[ ! -z $(cat /etc/emulationstation/es_input.cfg | grep "190000004b4800000010000001010000") ]]; then
      param_device="oga"
      if [ ! -f "/roms/ports/nxengine-evo/conf/nxengine/settings.dat" ]; then
        mv -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.480 /roms/ports/nxengine-evo/conf/nxengine/settings.dat
        rm -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.*
      fi
	else
	  param_device="rk2020"
      if [ ! -f "/roms/ports/nxengine-evo/conf/nxengine/settings.dat" ]; then
        mv -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.480 /roms/ports/nxengine-evo/conf/nxengine/settings.dat
        rm -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.*
      fi
	fi
elif [[ -e "/dev/input/by-path/platform-odroidgo3-joypad-event-joystick" ]]; then
  param_device="ogs"
  if [ ! -f "/roms/ports/nxengine-evo/conf/nxengine/settings.dat" ]; then
    mv -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.ogs /roms/ports/nxengine-evo/conf/nxengine/settings.dat
    rm -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.*
  fi
else
  param_device="chi"
  if [ ! -f "/roms/ports/nxengine-evo/conf/nxengine/settings.dat" ]; then
    mv -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.640 /roms/ports/nxengine-evo/conf/nxengine/settings.dat
    rm -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.*
  fi
fi


if [ -f "/opt/system/Advanced/Switch to main SD for Roms.sh" ]; then
  if [ ! -f "/roms2/ports/nxengine-evo/conf/nxengine/settings.dat" ]; then
    mv -f /roms2/ports/nxengine-evo/conf/nxengine/settings.dat.640 /roms2/ports/nxengine-evo/conf/nxengine/settings.dat
    rm -f /roms2/ports/nxengine-evo/conf/nxengine/settings.dat.*
  fi
  $ESUDO rm -rf ~/.local/share/nxengine
  $ESUDO ln -s /roms2/ports/nxengine-evo/conf/nxengine ~/.local/share/
  cd /roms2/ports/nxengine-evo
  $ESUDO ./oga_controls nxengine-evo $param_device &
  ./nxengine-evo
  $ESUDO kill -9 $(pidof oga_controls)
  $ESUDO systemctl restart oga_events &
  printf "\033c" >> /dev/tty1
else
  if [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ $(cat "/storage/.config/.OS_ARCH") == "RG351V" ] || [ $(cat "/storage/.config/.OS_ARCH") == "RG351MP" ]; then
    if [ ! -f "/roms/ports/nxengine-evo/conf/nxengine/settings.dat" ]; then
      mv -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.640 /roms/ports/nxengine-evo/conf/nxengine/settings.dat
      rm -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.*
    fi
  else
    if [ ! -f "/roms/ports/nxengine-evo/conf/nxengine/settings.dat" ]; then
      mv -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.480 /roms/ports/nxengine-evo/conf/nxengine/settings.dat
      rm -f /roms/ports/nxengine-evo/conf/nxengine/settings.dat.*
    fi
  fi
  $ESUDO rm -rf ~/.local/share/nxengine
  $ESUDO ln -s /roms/ports/nxengine-evo/conf/nxengine ~/.local/share/
  ln -s /roms/ports/nxengine-evo/ /usr/local/share/nxengine
  cd /roms/ports/nxengine-evo 
  $ESUDO ./oga_controls nxengine-evo $param_device &
  ./nxengine-evo
  $ESUDO kill -9 $(pidof oga_controls)
  $ESUDO systemctl restart oga_events &
  printf "\033c" >> /dev/tty1
fi
