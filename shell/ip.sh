#!/bin/bash
cfont()
{
  while (($#!=0))
    do
    case $1 in
    -b)
      echo -ne " ";
    ;;
    -t)
      echo -ne "\t";
    ;;
    -n)     echo -ne "\n";
    ;;
    -black)
      echo -ne "\033[30m";
    ;;
    -red)
      echo -ne "\033[31m";
    ;;
    -green)
      echo -ne "\033[32m";
    ;;
    -yellow)
      echo -ne "\033[33m";
    ;;
    -blue)
      echo -ne "\033[34m";
    ;;
    -purple)
      echo -ne "\033[35m";
    ;;
    -cyan)
      echo -ne "\033[36m";
    ;;
    -white|-gray) echo -ne "\033[37m";
    ;;
    -reset)
      echo -ne "\033[0m";
    ;;
    -h|-help|--help)
      echo "Usage: cfont -color1 message1 -color2 message2 ...";
    ;;
    *)
      echo -ne "$1"
      ;;
    esac
      shift
      done
}

until false
do
nmap -sP 139.226.64.11-50 > ./ip.tmp
IP=0
echo ""
echo "                            Libera IP Mapping"
echo ""
echo "-----------------------------------------------------------------------"
for C in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
do
echo -ne "|  "
for N in 1 2 3 4 5 6 7
do
IP=`expr $C \* 7 + $N + 3`
if ((`cat ./ip.tmp |grep -c "64.$IP\>"` != 0))
then
cfont -green "C$C-$N"
cfont -reset
echo -ne "  |  "
else
cfont -red "C$C-$N"
cfont -reset
echo -ne "  |  "
fi
done
echo ""
echo "-----------------------------------------------------------------------"
done
#rm ./ip.tmp
done
