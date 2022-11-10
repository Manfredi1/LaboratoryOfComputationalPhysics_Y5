#!/bin/bash

mkdir ~/students
cd ~/students

#check file
if [ ! -f "list.csv" ]
then
    wget -O "list.csv" "https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv"
else
    echo "download already done!"
fi

#splitting students in two lists
grep "PoD" "list.csv" > "pod.csv"
grep "Physics" list.csv > "phy.csv"
echo "Splitting done!"

#count
m=0
for i in {A..Z}
do
    echo -n "$i: "
    j=`cut -f1 -d "," pod.csv phy.csv| grep -c "^$i.*"`
    echo "$j students"    
    if [ $j -gt $m ]
    then
        m=$j
    fi
done

echo "------------"
echo "most popular letter has $m occurrence"
