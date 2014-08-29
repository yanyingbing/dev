#!/bin/bash
until false
do
./liberas -s SR "hostname;rdate -s 10.30.1.11"
sleep 86400
done
