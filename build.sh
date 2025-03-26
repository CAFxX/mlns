#!/bin/sh

for i in `seq 2 9`; do
    echo $i fast
    ruby mlnsgen/mlnsgenfast.rb $i > nsorter_${i}_fast.v
done
for i in `seq 2 16` 32 64; do
    echo $i large
    ruby mlnsgen/mlnsgenlarge.rb $i > nsorter_${i}_large.v
done

for i in `seq 2 9`; do 
    echo $i fast
    yosys -p "read_verilog nsorter_${i}_fast.v; synth" | egrep '^\s+(Number of cells:|[$]_).*'
done
for i in `seq 2 16` 32 64; do 
    echo $i large
    yosys -p "read_verilog nsorter_${i}_large.v; synth" | egrep '^\s+(Number of cells:|[$]_).*'
done

for i in `seq 2 16`; do
    rm -rf build/nsorter_$i
    sc -remote -constraint_density 5 -O3 nsorter_${i}_large.v
done
