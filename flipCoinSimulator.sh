#!/bin/bash -x

head=0
tail=0

declare -A dict

function doublet() {
	singlet_Value=$((RANDOM%2))
	if [ $singlet_Value -eq 0 ]
	then
		echo "H"
	else
		echo "T"
	fi
}

function singlet() {
flip_Value=$1

for (( i=0 ; i<$flip_Value ; i++ ))
do
	flip_Coin_Value=$((RANDOM%10))
	if [ $flip_Coin_Value -lt 5 ]
	then
		if [ $2 == true ]
		then
			((head++))
			doublet=$( doublet )
			dict["flip $i"]="H$doublet"
		else
			((head++))
			dict["flip $i"]="H"
		fi
	else
		if [ $2 == true ]
		then
			((tail++))
			doublet=$( doublet )
			dict["flip $i"]="T$doublet"
		else
			((tail++))
			dict["flip $i"]="T"
		fi
	fi
done
echo "$head $tail ${dict[@]}"
}

read -p "Enter number of times: " num
echo "1. Singlet flip coin"
echo "2. Doublet flip coin"
read choice

if [ $num -gt 0 ]
then
	if [ $choice -eq 1 ]
	then
		read headCount tailCount dictValue < <( singlet $num false )
	else
		read headCount tailCount dictValue < <( singlet $num true )
	fi
	echo "Head Count--> $headCount"
	echo "Tail Count--> $tailCount"
	total=$(( $headCount+$tailCount ))
	head_Percent=$(( $(( $headCount*100 )) / $total ))
	tail_Percent=$(( $(( $tailCount*100 )) / $total ))
	echo "Percentage of head--> $head_Percent"
	echo "Percentage of tail--> $tail_Percent"
	echo "Dictionary Values--> $dictValue"
else
	echo "Number must be greater than zero."
fi
