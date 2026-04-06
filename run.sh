#!/bin/bash
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: ./run.sh ENTITY"
    echo "Example (in project root): ./run.sh counter.counter_tb"
    echo "Example (in library counter): ./run.sh counter_tb"
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
    if [[ $SUBLIB != "work" ]]; then
        echo "Import $SUBLIB..."
        mkdir -p ../$SUBLIB/work
        ghdl -i --work=$SUBLIB --workdir=../$SUBLIB/work ../$SUBLIB/**.vhd
        workdirs[$i]="-P../${workdirs[$i]}work"
    else
        unset 'workdirs[i]'
    fi
done

echo "Make $1 (lib $LIB)..."
ghdl -m --work=$LIB --workdir=../$LIB/work ${workdirs[@]} $1

echo "Run $1..."
ghdl -r $1 --stop-time=3100ns --wave=$1.ghw

echo "Wave $1..."
gtkwave $1.ghw --rcvar 'do_initial_zoom_fit yes'
