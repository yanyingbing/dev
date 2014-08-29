#!/bin/bash
sudo modprobe pcspkr
until false
do
C=`/home/yanyb/cur.sh`
if [ `echo "$C<190" |bc` -eq 1 ]
then
beep -f 1000 -n -f 2000 -n -f 1500
fi
echo $C
sleep 60
#sleep 1
done
