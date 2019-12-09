#!/bin/bash -x

head=0
tail=0

declare -A dict

read -p "Enter number of times: " num

if [ $num -gt 0 ]
then
	for (( i=0 ; i<$num ; i++ ))
	do
		flip_Coin_Value=$((RANDOM%10))
		if [ $flip_Coin_Value -lt 5 ]
		then
			((head++))
			dict["flip $i"]="H"
		else
			((tail++))
			dict["flip $i"]="T"
		fi
	done
	echo "head--> $head tail--> $tail"
#	echo ${dict[@]}
else
	echo "Number must be greater than zero."
fi
