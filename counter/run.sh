#!/bin/bash

mkdir -p work
cd work
ghdl -i ../**.vhd
#ghdl -m -fexplicit --ieee=synopsys top_level_tb
ghdl -m counter_tb
ghdl -r counter_tb --stop-time=3100ns --wave=wave.ghw
gtkwave wave.ghw --rcvar 'do_initial_zoom_fit yes'
