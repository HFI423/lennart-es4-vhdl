#!/bin/bash
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: ./run.sh ENTITY"
    echo "Example: ./run.sh counter.counter_tb"
    exit 1
fi

workdirs=(*/);
for i in "${!workdirs[@]}"; do
    SUBLIB=$(echo "${workdirs[$i]}" | cut -d/ -f1)
    if [[ $SUBLIB != "work" ]]; then
        ./import.sh $SUBLIB
        workdirs[$i]="-P../${workdirs[$i]}work"
    else
        unset 'workdirs[i]'
    fi
done

LIB=$(echo $1 | cut -d. -f1)
cd work

echo "Make $1 (lib $LIB)..."
ghdl -m --work=$LIB --workdir=../$LIB/work ${workdirs[@]} $1

echo "Run $1..."
ghdl -r $1 --stop-time=3100ns --wave=$1.ghw

echo "Wave $1..."
gtkwave $1.ghw --rcvar 'do_initial_zoom_fit yes'
