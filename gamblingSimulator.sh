#!/bin/bash -x
echo "Welcome to the GAMBLING SIMULATOR"

#constant
BET=1
DAYS=20
WIN=1
LOSS=0
STAKE=100
DAILY_LOW_LIMIT=$(( $STAKE / 2 ))
DAILY_HIGH_LIMIT=$(($STAKE / 2 + $STAKE))

declare -A gameRecord

function setDailyResult(){

	for(( day=1; day<=$DAYS; day++))
	do
		stake=$STAKE

		while [ $DAILY_LOW_LIMIT -lt $stake ] && [ $DAILY_HIGH_LIMIT -gt $stake ]
		do
			result=$(( RANDOM % 2))

			case $result in
				$WIN)
					stake=$(($stake + $BET));;

				$LOSS)
					stake=$(($stake - $BET));;
			esac

		done

		gameRecord["Day_$day"]=$(( $stake - $STAKE ))

	done
}

function getDailyProfit(){
	for((j=1;j<=$DAYS;j++))
	do
		echo "Day_$j ${gameRecord[Day_$j]}"
	done 
}

function getLuckyUnlucky(){

	for((j=1;j<=$DAYS;j++))
	do
		previousDay=$(( $j - 1 ))

		if [ $j -eq 1 ]
		then
			echo  "Day$j   "${gameRecord[Day_$j]}
		else
			gameRecord[Day_$j]=$(( ${gameRecord[Day_$previousDay]} + ${gameRecord[Day_$j]} ))
			echo  "Day$j	"${gameRecord[Day_$j]}
		fi

	done | sort -k2 -nr |awk 'NR==20{print "Unluckiest:	" $0}AND NR==1{print "Luckiest:	" $0}'
}

function main(){
	setDailyResult 
	getDailyProfit
	profit=$( printf "%s\n" ${gameRecord[@]} | awk '{sum+=$0}END{print sum}')
	echo "Profit " $profit
	getLuckyUnlucky
	playNextMonthOrNot $profit
}

function playNextMonthOrNot(){
	profit=$1

	if [ $profit -gt 0 ]
	then
		main 
	else
		echo "Thanks for playing..Better luck next time"
	fi
}

main
