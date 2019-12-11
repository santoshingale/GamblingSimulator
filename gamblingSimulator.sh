#!/bin/bash -x
echo "Welcome to the GAMBLING SIMULATOR"

#constant
BET=1
DAYS=20

declare -A gameRecord

stake=100
function getDailyResult(){

	for(( day=1; day<=$DAYS; day++))
	do
		stake=100
		DAILY_LOW_LIMIT=$(( $stake / 2 ))
		DAILY_HIGH_LIMIT=$(($stake / 2 + $stake))

		while [ $DAILY_LOW_LIMIT -lt $stake ] && [ $DAILY_HIGH_LIMIT -gt $stake ]
		do
			result=$(( RANDOM % 2))
			case $result in
				1)
					((stake++));;

				0)
					((stake--));;
			esac
		done
		outCome=$(( $stake - 100 ))
		gameRecord["Day_$day"]=$outCome
	done
}

getDailyResult

for((j=1;j<=20;j++))
do
	echo "Day_$j ${gameRecord[Day_$j]}"
done 

echo "Total profit" $( printf "%s\n" ${gameRecord[@]} | awk '{sum+=$0}END{print sum}')
