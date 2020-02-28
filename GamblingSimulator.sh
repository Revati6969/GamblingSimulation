#!/bin/bash -x

STAKE=100
maxLimit=0
minLimit=0
DAYS=20
totalWin=0
totalLoss=0

dailyBetAmount=$STAKE

function limit () {
   maxLimit=$(($dailyBetAmount+$dailyBetAmount*50/100))
   minLimit=$(($dailyBetAmount-$dailyBetAmount*50/100))
}

function betting()
{
   for (( counter=1; counter<=$DAYS; counter++ ))
   do
      dailyBetAmount=100
      totalWin=0
      totalLoss=0
      while [[ $dailyBetAmount -ne 0 ]]	
      do
	random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then 
	    ((dailyBetAmount++))
	    if [ $dailyBetAmount -eq $maxLimit ]
	    then 
		break
        fi
        else
	    ((dailyBetAmount--))
	    if [ $dailyBetAmount -eq $minLimit ]
	    then 
                break
            fi
        fi
       done

       if [ $dailyBetAmount -eq $maxLimit ]
       then
           totalWin=$(($maxLimit-$STAKE))
       else
           totalLoss=$(($STAKE-$minLimit))
       fi
       echo "day: $counter  Amount: $dailyBetAmount  Win: $totalWin  Loss:$totalLoss"
done
}
 
limit
betting
