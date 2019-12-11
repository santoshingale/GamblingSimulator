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
		wins=0
		losses=0
		DAILY_LOW_LIMIT=$(( $stake / 2 ))
		DAILY_HIGH_LIMIT=$(($stake / 2 + $stake))

		while [ $DAILY_LOW_LIMIT -lt $stake ] && [ $DAILY_HIGH_LIMIT -gt $stake ]
		do
			result=$(( RANDOM % 2))
			case $result in
				1)
					((stake++))
					((wins++));;

				0)
					((stake--))
					((losses++));;
			esac
		done
		outCome=$(( $stake - 100 ))
		gameRecord["Day_$day"]=$wins" "$losses
	done
}

getDailyResult

for i in ${!gameRecord[@]}
do
	echo "$i ${gameRecord[$i]}"
done | sort -k2 -n
