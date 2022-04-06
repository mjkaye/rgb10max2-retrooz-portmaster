#!/bin/bash
BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
cd "${BASEDIR}/devilution"
FILE=./diabdat.mpq
echo "Diablo Devilution: " | tee ~/.emulationstation/last_launch.log
if test -f "$FILE"; then
   export SDL_GAMECONTROLLERCONFIG="$(cat /roms/ports/devilution/gamecontrollerdb.txt)"
   ./devilutionx 2>&1 | tee -a ~/.emulationstation/last_launch.log
   unset SDL_GAMECONTROLLERCONFIG
   unset LD_LIBRARY_PATH
else
   str=$'The required Diablo file diabdat.mpq is missing or is not correctly named.'
   echo $str | tee -a ~/.emulationstation/last_launch.log
   msgbox "$str"
fi
