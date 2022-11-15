#!/bin/bash

cd ~/students

#PARTE 1
#mkdir files
#sed -n '2~18p' list.csv > files/list_1.txt
#for ((count=0; count<18; count++))
#do 
#    echo `sed -n $(($count+2))~18p list.csv > files/list_$count.txt`
#done

#PARTE 2
grep -v "^# " data.csv | sed -e "s/, / /g" > data.txt
line=`grep -c "^" data.txt`
echo "There are $line lines"

#PARTE 3
for ((rep=0; rep<2; rep++))
do
    bigger=0
    smaller=0
    for ((i=1; i<=line; i++))
    do
        a=p
        x=`sed -n $i$a data.txt |cut -d " " -f $((1+3*rep))`
        y=`sed -n $i$a data.txt |cut -d " " -f $((2+3*rep))`
        z=`sed -n $i$a data.txt |cut -d " " -f $((3+3*rep))`
        value=`echo "scale=3;sqrt($x^2 + $y^2 + $z^2)" | bc`
        confront=`echo "scale=3;100*sqrt(3)/2" | bc`
        res=`echo "$value < $confront" | bc`
        if [[ $res == 1 ]]
        then
            smaller=$(($smaller+1))
        else
            #bigger=$(($bigger+1))
            bigger=$(( $bigger+1 ))
        fi
    done
    echo "in sample $(($rep+1)) we have smaller:$smaller, bigger:$bigger"
done

#PARTE 4
if [ -z $1 ]
then
    echo "this part of the script requires as input the number of the copies to be created"
    exit
fi

copies=$1
mkdir Ncopy
for ((j=1; j<copies; j++))
do
    echo "-----copy $j-----"
    for ((i=1; i<=line; i++))
    do     
        a=p
        x1=`cut -d " " -f 1 data.txt | sed -n $i$a`
        x2=`cut -d " " -f 2 data.txt | sed -n $i$a`
        x3=`cut -d " " -f 3 data.txt | sed -n $i$a`
        x4=`cut -d " " -f 4 data.txt | sed -n $i$a`
        x5=`cut -d " " -f 5 data.txt | sed -n $i$a`
        x6=`cut -d " " -f 6 data.txt | sed -n $i$a`
        x1=`echo "scale=3;$x1/$j" | bc`
        x2=`echo "scale=3;$x2/$j" | bc`
        x3=`echo "scale=3;$x3/$j" | bc`
        x4=`echo "scale=3;$x4/$j" | bc`
        x5=`echo "scale=3;$x5/$j" | bc`
        x6=`echo "scale=3;$x6/$j" | bc`
        echo "$x1 $x2 $x3 $x4 $x5 $x6" >> Ncopy/copy_$j.txt
    done
done
