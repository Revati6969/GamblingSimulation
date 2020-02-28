#!/bin/bash -x

STAKE=100
maxLimit=0
minLimit=0
DAYS=20
totalStake=0
VALUE=50

dailyBetAmount=$STAKE
declare -A Dictionary


maxLimit=$(($dailyBetAmount+$dailyBetAmount*50/100))
minLimit=$(($dailyBetAmount-$dailyBetAmount*50/100))

function betting()
{
   for (( counter=1; counter<=$DAYS; counter++ ))
   do
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

      if [ $dailyBetAmount -eq $minLimit ]
      then
         totalStake=$(($totalStake-$VALUE))
         Dictionary[$counter]=$totalStake
      else
         totalStake=$(($totalStake+$VALUE))
         Dictionary[$counter]=$totalStake
      fi
      dailyBetAmount=100
done
echo "totalStake: $totalStake"
}
 
function luckyOrNot()
{
   echo "your Stakes: " $totalStake

   profitValue=$(printf "%s\n" ${Dictionary[@]} | sort -n | tail -1 )
   lossValue=$(printf "%s\n" ${Dictionary[@]} | sort -n | head -1 )

   echo profitValue: $profitValue
   echo lossValue :$lossValue

   echo "day: " ${!Dictionary[@]} 
   echo "stake: "${Dictionary[@]}

   for key in ${!Dictionary[@]}
   do
      if [[ ${Dictionary[$key]} -eq $profitValue ]]
      then
         echo "lucky day :$key"
      fi

      if [[ ${Dictionary[$key]} -eq $lossValue ]]
      then
         echo "unlucky day :$key"
      fi
	done
}

betting
luckyOrNot

if [ $totalStake -gt 0 ]
then
    read -p "do you want to countinue 1.Yes 2.No :" toCountinue
    if [ $toCountinue -eq 1 ]
    then
        betting
	luckyOrNot
    else
        echo "Game Over"
    fi
fi

