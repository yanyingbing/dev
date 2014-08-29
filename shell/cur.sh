#!/bin/bash
wget -q 'http://159.226.222.249/ssrf/beam/' -O - |grep mA | cut -d '>' -f2 | cut -d 'm' -f1
