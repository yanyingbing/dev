#/bin/bash
L2A=0
L3A=0
X=77
Y=50
while read L1 L2 L3 L4
do

if [ "$L2" = "$L2A" ] || [ "$L3" = "$LA3" ]
then
  N=`expr $N + 1`	

	if [ "$N" -eq "8"	]
  then		
    if [ "$L3" -eq "5"	]
  	then	
			echo "# (Static Text)"																	
			echo "object activeXTextClass"																	
			echo "beginObjectProperties"																	
			echo "major 4"																	
			echo "minor 1"																	
			echo "release 0"		
			X=`expr $X + 30`								
			echo "x $X"
			YT=`expr $Y + 5`		
			echo "y $YT"
			echo "w 64"																	
			echo "h 16"																	
			echo "font \"helvetica-bold-r-14.0\""																	
			echo "fgColor index 48"																	
			echo "bgColor index 19"																	
			echo "useDisplayBg"																	
			echo "value {"																					
			echo "  \" \""																	
			echo "}"
			echo "autoSize"																	
			echo "endObjectProperties"
			echo " "
	  fi
	X=77
	Y=`expr $Y + 30`	
	N=1
  fi

	echo "# (Rectangle)"																	
	echo "object activeRectangleClass"																	
	echo "beginObjectProperties"																	
	echo "major 4"																	
	echo "minor 0"																	
	echo "release 0"	
	X=`expr $X + 30`								
	echo "x $X"
	YT=`expr $Y - 5`	
	echo "y $YT"
	echo "w 25"																	
	echo "h 25"																	
	echo "lineColor index 0"																	
	echo "fill"																	
	echo "fillColor index 17"																	
	echo "fillAlarm"																	
	echo "alarmPv \"$L1:STATUS\""																	
	echo "endObjectProperties"											
	echo " "

else

	echo "# (Static Text)"																	
	echo "object activeXTextClass"																	
	echo "beginObjectProperties"																	
	echo "major 4"																	
	echo "minor 1"																	
	echo "release 0"																
	echo "x 20"
	Y=`expr $Y + 30`	
	echo "y $Y"
	echo "w 64"																	
	echo "h 16"																	
	echo "font \"helvetica-bold-r-14.0\""	
	echo "fontAlign \"right\""	                																
	echo "fgColor index 48"																	
	echo "bgColor index 19"																	
	echo "useDisplayBg"																	
	echo "value {"																					
	echo "  \"$L4\""																	
	echo "}"
	echo "autoSize"																	
	echo "endObjectProperties"
	echo " "

	echo "# (Rectangle)"																	
	echo "object activeRectangleClass"																	
	echo "beginObjectProperties"																	
	echo "major 4"																	
	echo "minor 0"																	
	echo "release 0"															
	X=107
	echo "x $X"
	YT=`expr $Y - 5`	
	echo "y $YT"
	echo "w 25"																	
	echo "h 25"																	
	echo "lineColor index 0"																	
	echo "fill"																	
	echo "fillColor index 17"																	
	echo "fillAlarm"																	
	echo "alarmPv \"$L1:STATUS\""																	
	echo "endObjectProperties"
	echo " "

N=1
fi

L2A=$L2
L3A=$L3
done < ./list

