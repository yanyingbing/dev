#!/bin/bash
for C in 01 02
do
  for N in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
  do
    echo "dbLoadRecords("\"db/StatisticD.db\"","\"device=SB-BI:H"$C"BPM"$N":SA:X,record=SB-BI:"H$C"BPM"$N":SA:X,count=2048,spectrum=1024,cycle=.5 second\"")"
    echo "dbLoadRecords("\"db/StatisticD.db\"","\"device=SB-BI:"H$C"BPM"$N":SA:Y,record=SB-BI:H"$C"BPM"$N":SA:Y,count=2048,spectrum=1024,cycle=.5 second\"")"
    if [ $N = 15 ]; then
        echo
    fi
  done
done


