#!/bin/bash

string=$(grep -w -i 'OS' $1)
#-i baraye in ast ke mikhahim beyne horoofe koochak
# va bozorg tafavot ghael nashavad 
#-w baraye khandane kalame estefade mishavad
echo " hello visitor "
sleep 2
if [ $? == 0 ]
then
echo " string found  "
elif [ $? == 1 ]
then
echo " any strings not found "
else
break
fi


