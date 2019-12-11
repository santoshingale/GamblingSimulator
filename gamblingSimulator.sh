#!/bin/bash -x
echo "Welcome to the GAMBLING SIMULATOR"

#constant
BET=1
stake=100
function getDailyResult(){

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

	echo $stake
}

getDailyResult
