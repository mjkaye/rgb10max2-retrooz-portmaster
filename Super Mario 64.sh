#!/bin/sh
echo "SUPER MARIO 64 PORT: " | tee ~/.emulationstation/last_launch.log
/roms/ports/sm64/sm64.us.f3dex2e 2>&1 | tee -a ~/.emulationstation/last_launch.log

