#! /bin/sh
if [ $# -eq 3 ]; then
  COUNTER=0
  while [ $COUNTER -lt $2 ]
  do
    caget -w 5 -t "$1:SA:X" > TemporaryFileA
    
    tr -s "\n" " " < TemporaryFileA > TemporaryFileB
    caget -w 5 -t "$1:SA:Y" >> TemporaryFileB
    cat TemporaryFileB >> $3
    COUNTER=`expr $COUNTER + 1`
    rm -f TemporaryFileA TemporaryFileB
  done
  echo "Complete!"
else
  echo "Error! Wrong Number of Parameter."
fi

