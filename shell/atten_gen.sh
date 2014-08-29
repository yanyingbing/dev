#!/bin/bash
for C in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
do
  for N in 1 2 3 4 5 6 7
  do
    echo "ATTEN=\`caget -t SR-BI:"$C"BPM"$N":CF:ATTEN_S\`"
    echo "ATTEN=\`expr \$ATTEN - \$1\`"
    echo "caput SR-BI:"$C"BPM"$N":CF:ATTEN_S \$ATTEN"

  done
done

