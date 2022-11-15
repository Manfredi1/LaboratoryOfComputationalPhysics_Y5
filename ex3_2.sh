#!/bin/bash

cd ~/students

count=`cat -n list.csv | cut -f1`

for i in $count
do
    echo $i
done
