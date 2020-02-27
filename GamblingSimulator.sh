#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

#Constants
STAKE=100
BET=1 

dailyBetAmount=$STAKE

function betting()
{
	random=$((RANDOM%2))

	if [[ $random -eq 1 ]]
	then
		echo "you won 1 bet"
		((dailyBetAmount++))
	else
		echo "you loose 1 bet"
		((dailyBetAmount--))
	fi
	echo $dailyBetAmount
}
betting

