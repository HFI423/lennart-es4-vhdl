#!/bin/bash
set -e

if [ "$#" -eq 0 ]; then
    echo "Usage: ./run.sh ENTITY [STOP_TIME, default 1000ns]"
    echo "Example (in project root): ./run.sh counter.counter_tb"
    echo "Example (in library counter): ./run.sh counter_tb 1000ns"
    exit 1
fi

ENTITY=$1
LIB=$(echo $1 | cut -d. -f1)

if [[ $ENTITY != *"."* ]]; then
    LIB=$(pwd | rev | cut -d/ -f1 | rev)
    ENTITY="$LIB.$ENTITY"
    cd ..
fi

workdirs=(*/);
mkdir -p work
cd work

for i in "${!workdirs[@]}"; do
    SUBLIB=$(echo "${workdirs[$i]}" | cut -d/ -f1)
    if [[ $(ls -R ../$SUBLIB) == *".vhd"* ]]; then
        echo "Import $SUBLIB..."
        mkdir -p ../$SUBLIB/work
        ghdl -i --std=93 --work=$SUBLIB --workdir=../$SUBLIB/work $(find ../$SUBLIB -name "*.vhd")
        workdirs[$i]="-P../${workdirs[$i]}work"
    else
        unset 'workdirs[i]'
    fi
done

echo "Make $1 (lib $LIB)..."
ghdl -m --std=93 --work=$LIB --workdir=../$LIB/work ${workdirs[@]} $1

echo "Run $1..."
ghdl -r --std=93 $1 --stop-time=${2:-1000ns} --wave=$1.ghw --assert-level=warning

echo "Wave $1..."
gtkwave $1.ghw --rcvar 'do_initial_zoom_fit yes'
