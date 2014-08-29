#!/bin/bash
TS=0
TE=0

transform()
{
  if ((`echo $1 | grep -c Bool` != 0))
  then
    case $2 in
    0)
      echo "false"
      ;;
    1)
      echo "true"
      ;;
    *)
      echo $2
      ;;
    esac
  elif ((`echo $1 | grep -c Enumeration` != 0))
  then
    case $2 in
    0)
      echo "Enum2"
      ;;
    1)
      echo "Enum3"
      ;;
    2)
      echo "Enum1"
      ;;
    *)
      echo $2
      ;;
    esac
  else
    echo $2
  fi
}

ireg_read()
{
  if ((`echo $1 | grep -c :v:` != 0))
  then
    V=`libera-ireg ${NODE//:/.} | cut -d " " -f2`
    echo $V
  fi
  if ((`echo $1 | grep -c :a:` != 0))
  then
    NOD=`echo $1 | cut -d ":" -f2- | cut -d "-" -f1`
    NUM=`echo $1 | cut -d ":" -f2- | cut -d "-" -f2`
    NUM=`expr $NUM + 1`
    if [ "$NUM" == "1" ]
    then
      V=`libera-ireg ${NOD//:/.} | cut -d "," -f$NUM | cut -d "[" -f2`
      echo $V
    else
      V=`libera-ireg ${NOD//:/.} | cut -d "," -f$NUM`
      echo $V
    fi
  fi
}

ireg_write()
{
  if ((`echo $1 | grep -c :v:` != 0))
  then
    libera-ireg ${NODE//:/.}=$2
  fi
  if ((`echo $1 | grep -c :a:` != 0))
  then
    NUM=`echo $1 | cut -d ":" -f2- | cut -d "-" -f2`
    NUM=`expr $NUM + 1`
    STR=
    for i in `seq 10`
    do
      if (($i == $NUM))
      then
        STR=${STR}$2
      else
        if ((`echo $1 | grep -c Enumeration` != 0))
        then
          STR=${STR}Enum2
	else
          STR=${STR}0
        fi
      fi
      if (($i < 10))
      then
        STR=${STR},
      fi
    done
    libera-ireg ${NODE//:/.}=$STR
  fi
}

while read PV
do

if ((`echo $PV | grep -c Double` != 0))
then
  VA=3.14
  VB=-3.14
  VC=6.28
  VD=-6.28
  VE=1.79769e+308
  VF=2.22507e-308
  VG=1.79769e+309
  VH=2.22507e-309
fi

if ((`echo $PV | grep -c Float` != 0))
then
  VA=3.14
  VB=-3.14
  VC=6.28
  VD=-6.28
  VE=1.79769e+38
  VF=1.17549e-38
  VG=1.79769e+39
  VH=1.17549e-39
fi

if ((`echo $PV | grep -c String` != 0))
then
  VA=ABC
  VB=
  VC=abc
  VD=
  VE=AAAAAAAAAoBBBBBBBBBoCCCCCCCCCoDDDDDDDDD
  VF=
  VG=AAAAAAAAA-BBBBBBBBB-CCCCCCCCC-DDDDDDDDD-EEEEE
  VH=
fi

if ((`echo $PV | grep -c Bool` != 0))
then
  VA=1
  VB=0
  VC=1
  VD=0
  VE=true
  VF=false
  VG=2
  VH=-1
fi

if ((`echo $PV | grep -c :Long` != 0))
then
  VA=666
  VB=-666
  VC=888
  VD=-888
  VE=2147483647
  VF=-2147483648
  VG=2147483648
  VH=-2147483649
fi

if ((`echo $PV | grep -c ULong` != 0))
then
  VA=666
  VB=
  VC=888
  VD=
  VE=2147483647
  VF=
  VG=2147483648
  VH=-1
fi

if ((`echo $PV | grep -c Enumeration` != 0))
then
  VA=1
  VB=0
  VC=Enum3
  VD=Enum2
  VE=Enum1
  VF=Enum3
  VG=
  VH=
fi

NODE=`echo $PV | cut -d ":" -f2- | cut -d "-" -f1`
echo $'\r'
echo "----------------------------------------------------"
echo $PV | cut -d ":" -f2-
echo "----------------------------------------------------"
echo $'\r'

echo "+++ caget & read"
caget $PV-I
echo -n "libera-ireg "
libera-ireg ${NODE//:/.}
RB1=`caget -t $PV-I`
RB2=`ireg_read $PV`
if [ $RB1 == $RB2 ]
then
  echo "> OK"
else
  echo "> ER"
fi
echo $'\r'

#----------------------------------------------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0)) || ((`echo $PV | grep -c :rd:` == 0))
then
  if [ -n "$VA" ] 
  then
    echo "+++ caput" 
    caput $PV-O $VA
    echo "> caget & read"
    caget $PV-I
    echo -n "libera-ireg "
    libera-ireg ${NODE//:/.}
    RB1=`caget -t $PV-I`
    RB2=`ireg_read $PV`
    VA=`transform $PV $VA`
    if [ $RB1 == $VA ] && [ $RB2 == $VA ]
    then
      echo "> OK"
    else
      echo "> ER"
    fi
    echo $'\r'
  fi
fi

#----------------------------------------------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0)) || ((`echo $PV | grep -c :rd:` == 0))
then
  if [ -n "$VB" ] 
  then
    echo "+++ caput" 
    caput $PV-O $VB
    echo "> caget & read"
    caget $PV-I
    echo -n "libera-ireg "
    libera-ireg ${NODE//:/.}
    RB1=`caget -t $PV-I`
    RB2=`ireg_read $PV`
    VB=`transform $PV $VB`
    if [ $RB1 == $VB ] && [ $RB2 == $VB ]
    then
      echo "> OK"
    else
      echo "> ER"
    fi
    echo $'\r'
  fi
fi

#----------------------------------------------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0)) || ((`echo $PV | grep -c :rd:` != 0))
then
  if [ -n "$VC" ]
  then
    echo "+++ write (libera-ireg)"
    #VAC=`echo $VA + 1 | bc`
    NOD=`echo $PV | cut -d ":" -f2-`
    echo "libera-ireg ${NOD//:/.}="$VC
    ireg_write $PV $VC
    echo "> caget & read"
    caget $PV-I
    echo -n "libera-ireg "
    libera-ireg ${NODE//:/.}
    RB1=`caget -t $PV-I`
    RB2=`ireg_read $PV`
    VC=`transform $PV $VC`
    if [ $RB1 == $VC ] && [ $RB2 == $VC ]
    then
      echo "> OK"
    else
      echo "> ER"
    fi
    echo $'\r'
  fi
fi

#----------------------------------------------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0)) || ((`echo $PV | grep -c :rd:` != 0))
then
  if [ -n "$VD" ]
  then
    echo "+++ write (libera-ireg)"
    #VBC=`echo $VB - 1 | bc`
    NOD=`echo $PV | cut -d ":" -f2-`
    echo "libera-ireg ${NOD//:/.}="$VD
    ireg_write $PV $VD
    echo "> caget & read"
    caget $PV-I
    echo -n "libera-ireg "
    libera-ireg ${NODE//:/.}
    RB1=`caget -t $PV-I`
    RB2=`ireg_read $PV`
    VD=`transform $PV $VD`
    if [ $RB1 == $VD ] && [ $RB2 == $VD ]
    then
      echo "> OK"
    else
      echo "> ER"
    fi
    echo $'\r'
  fi
fi

#----------------------------------------------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0)) || ((`echo $PV | grep -c :rd:` == 0))
then
  if [ -n "$VE" ] 
  then
    echo "+++ caput (max)"
    caput $PV-O $VE
    echo "> caget & read"
    caget $PV-I
    echo -n "libera-ireg "
    libera-ireg ${NODE//:/.}
    RB1=`caget -t $PV-I`
    RB2=`ireg_read $PV`
    VE=`transform $PV $VE`
    if [ $RB1 == $VE ] && [ $RB2 == $VE ]
    then
      echo "> OK"
    else
      echo "> ER"
    fi
    echo $'\r'
  fi
fi

#----------------------------------------------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0)) || ((`echo $PV | grep -c :rd:` == 0))
then
  if [ -n "$VF" ]
  then
    echo "+++ caput (min)"
    caput $PV-O $VF
    echo "> caget & read"
    caget $PV-I
    echo -n "libera-ireg "
    libera-ireg ${NODE//:/.}
    RB1=`caget -t $PV-I`
    RB2=`ireg_read $PV`
    VF=`transform $PV $VF`
    if [ $RB1 == $VF ] && [ $RB2 == $VF ]
    then
      echo "> OK"
    else
      echo "> ER"
    fi
    echo $'\r'
  fi
fi

#----------------------------------------------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0)) || ((`echo $PV | grep -c :rd:` == 0))
then
  if [ -n "$VG" ]
  then
    echo "+++ caput (out of range)"
    caput $PV-O $VG
    echo "> caget & read"
    caget $PV-I
    echo -n "libera-ireg "
    libera-ireg ${NODE//:/.}
    RB1=`caget -t $PV-I`
    RB2=`ireg_read $PV`
    VG=`transform $PV $VG`
    if [ $RB1 == $RB2 ] && [ $RB1 != $VG ]
    then
      echo "> OK"
    else
      echo "> ER"
    fi
    echo $'\r'
  fi
fi

#----------------------------------------------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0)) || ((`echo $PV | grep -c :rd:` == 0))
then
  if [ -n "$VH" ]
  then
    echo "+++ caput (out of range)"
    caput $PV-O $VH
    echo "> caget & read"
    caget $PV-I
    echo -n "libera-ireg "
    libera-ireg ${NODE//:/.}
    RB1=`caget -t $PV-I`
    RB2=`ireg_read $PV`
    VH=`transform $PV $VH`
    if [ $RB1 == $RB2 ] && [ $RB1 != $VH ]
    then
      echo "> OK"
    else
      echo "> ER"
    fi
    echo $'\r'
  fi
fi

#--------------------------------------
if ((`echo $PV | grep -c :rdwr:` != 0))
then
  echo "+++ camonitor"
  camonitor $PV-I > i.tmp&
  camonitor $PV-O > o.tmp&
  if [ -n "$VA" ]; 
  then
    caput $PV-O $VA
  fi
  if [ -n "$VC" ]; 
  then
    echo "libera-ireg ${NODE//:/.}="$VC
    libera-ireg ${NODE//:/.}=$VC
  fi
  echo '>'
  cat i.tmp
  cat o.tmp
  rm i.tmp o.tmp
  echo $'\r'
fi


killall --quiet camonitor
echo "***"
done < ./node.list

