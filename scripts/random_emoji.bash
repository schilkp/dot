#!/bin/bash
array[0]="⚙️"
array[1]="🔬"
array[2]="🐉"
array[3]="🐋"
array[4]="🐙"
array[5]="🖥️"
array[6]="🥁"
array[7]="🪤"

size=${#array[@]}
index=$(($RANDOM % $size))
echo "${array[$index]}"
