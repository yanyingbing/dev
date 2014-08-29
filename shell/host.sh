#!/bin/bash
IP=0
for C in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
do
  for N in 1 2 3 4 5 6 7
  do
    IP=`expr $C \* 7 + $N`
    #echo "10.30.5."`expr $IP + 3`":5064"
    #echo "10.30.5."`expr $IP + 3`"	SR-BI:"$C"BPM"$N
    echo "SR-BI:"$C"BPM"$N
  done
done
Jungle

