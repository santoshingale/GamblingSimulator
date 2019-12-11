#!/bin/bash -x
echo "Welcome to the GAMBLING SIMULATOR"

#constant
BET=1
STAKE=100

result=$(( RANDOM % 2))
case $result in
	1)
		echo "win 1$";;

	0)
		echo "loss 1$";;
esac
