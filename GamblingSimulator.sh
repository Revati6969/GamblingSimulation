#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

#Constants
STAKE=100
BET=1 

dailyBetAmount=$STAKE

limit()
{
	maxLimit=$(($dailyBetAmount+$dailyBetAmount*50/100))
	minLimit=$(($dailyBetAmount-$dailyBetAmount*50/100))
}

function betting()
{
	while [[ $dailyBetAmount -ne 0 ]]
	do
		random=$((RANDOM%2))
		if [[ $random -eq 1 ]]
		then
			dailyBetAmount=$(( $dailyBetAmount + $BET ))
			if [[ $dailyBetAmount -eq $maxLimit ]]
			then
				echo "you have reached maximum limit"
				break
			fi
		else
			dailyBetAmount=$(( $dailyBetAmount - $BET ))
			if [[ $dailyBetAmount -eq $minLimit ]]
			then
				echo "you have reached minimum limit"
				break
			fi
		fi
	done

	echo $dailyBetAmount
}

limit
betting

