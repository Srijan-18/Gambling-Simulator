#!/bin/bash -x

echo "Welcome To Gambling Simulator"
BET_LOSE=0;
BET_WIN=1;
declare -A daysWon
declare -A daysLost

function betResult()
{
	case $1 in
		$BET_WIN)
			dailyAmount=$((dailyAmount+betAmount));
		;;
		$BET_LOSE)
			dailyAmount=$((dailyAmount-betAmount));
		;;
		*)
			echo"SOME ERROR"
		;;
	esac
	echo $dailyAmount
}
amountWon=0;
amountLost=0;
netResult=0;
winStreakAmount=0;
loseStreakAmount=0;
for ((dayCount=1; dayCount<=30; dayCount++ ))
do
	dailyAmount=100;
	betAmount=1;
	while ((dailyAmount<=150 && dailyAmount>=50 ))
	do
		betChance=$((RANDOM%2));
		dailyAmount=$(betResult $betChance);
	done
	if((dailyAmount<100))
	then
		amountLost=$((amountLost+50));
		daysLost["Day"$dayCount]=$((loseStreakAmount+50));
		winStreakAmount=0;
	else
		amountWon=$((amountWon+50));
		daysWon["Day"$dayCount]=$((winStreakAmount+50));
		loseStreakAmount=0;
	fi
done
echo "Wining Days are :" ${!daysWon[@]}
echo "Losing Days are :" ${!daysLost[@]}
echo "Amount Won = $amountWon"
echo "Amount Lost = $amountLost"
netResult=$((amountWon-amountLost));
if ((netResult>=0))
then
	echo "Net Winnings = $netResult"
else
	netResult=$((netResult* -1 ));
	echo "Net Loss = $netResult"
fi
