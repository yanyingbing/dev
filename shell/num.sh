#!/bin/bash
N=1
until false
do
echo $N

N=`expr $N + 1`
if (($N >= 100))
then
break
fi
done

