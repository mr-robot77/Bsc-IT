#!/bin/bash
echo " hello visitor "
sleep 2
#in dastor ebteda khush amad migooyad va 2sanie max mikonad
grep -q -s  os $1
# in khat va khat badi baraye in ast ke befahmim dastoor grep
#dorost ejra shode ast. agar file vared shode ghalat bashad yani
#exit status ma barabar 2 bashad peygham midahad ke file ghalat
#vared shode ast.
if [ $? == 2 ]
then echo 'file eshtebah ast lotfan file dorost ra be
onvane voroodi vared konid'
exit
fi
grep -q -w -i  'OS' $1 
if [ $? == 0 ]
#dar in ghesmat check mikonim agar dastoor 
#dorst ejra shod yani kalame os dar file mojood ast 
then echo 'kalame os dar file morede nazar mojood ast' 
#agar dastoor ghalat ejra shavad yani kalame os dar
#file mojood nabashad peygham midahad ke kalame mojood nist
else
echo 'kalame os dar file morede nazar mojood nist'
fi
#-q be hamrah -s baraye in estefade mishavad ke dastoor
#khorooji va eror ha ra rooye safhe neshan nadahad
#-i baraye in ast ke mikhahim beyne horoofe koochak va bozorg
# tafavot ghael nashavad 
#-w baraye khandane kalame estefade mishavad
