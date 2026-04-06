#!/bin/bash
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: ./run.sh LIBRARY"
    echo "Example: ./run.sh counter"
    exit 1
fi

mkdir -p work && cd work
mkdir -p ../$1/work

echo "Import $1..."
ghdl -i --work=$1 --workdir=../$1/work ../$1/**.vhd
