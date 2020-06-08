

choice=1;
echo "Welcome To Gambling Simulator"
monthCount=0;
while ((choice == 1 ))
do
	declare -A daysWon
	declare -A daysLost
	BET_LOSE=0;
	BET_WIN=1;

	function betResult()
	{
		case $1 in
			$BET_WIN)
				currentAmount=$((currentAmount+betAmount));
			;;
			$BET_LOSE)
				currentAmount=$((currentAmount-betAmount));
			;;
			*)
				echo"SOME ERROR"
			;;
		esac
		echo $currentAmount
	}
	function todaysResult()
	{
		currentAmount=100;
		while ((currentAmount<=101 && currentAmount>=99 ))
		do
			betChance=$((RANDOM%2));
			currentAmount=$(betResult $betChance);
		done
		echo $currentAmount

	}
	function lossDay()
	{
			amountLost=$((amountLost+50));
			netResult=$((netResult-50));
			daysLost["Day"$dayCount]=$netResult;
			if((largestLosingStreak>netResult))
			then
				largestLosingStreak=$netResult;
			fi
	}
	function gainDay()
	{
			amountWon=$((amountWon+50));
			netResult=$((netResult+50))
			daysWon["Day"$dayCount]=$netResult;
			if((largestWinningStreak<netResult))
			then
				largestWinningStreak=$netResult;
			fi
	}
	amountWon=0;
	amountLost=0;
	netResult=0;
	largestWinningStreak=0;
	largestLosingStreak=1500;

	for ((dayCount=1+monthCount; dayCount<=10+monthCount; dayCount++ ))
	do
		dailyAmount=100;
		betAmount=1;
		dailyAmount=$(todaysResult);
		if((dailyAmount<100))
		then
		lossDay;
		else
		gainDay;
		fi
	done

	echo "Wining Days are :" ${!daysWon[@]}
	echo "Losing Days are :" ${!daysLost[@]}
	echo "Luckiest Day(s)"
	for key in ${!daysWon[@]}
	do
		if [ ${daysWon[${key}]} -eq $largestWinningStreak ]
		then
			echo $key
		fi
	done
	echo "Unluckiest Day(s)"
	for key in ${!daysLost[@]}
	do
		if [ ${daysLost[${key}]} -eq $largestLosingStreak ]
		then
			echo $key
		fi
	done
	echo "Amount Won = $amountWon"
	echo "Amount Lost = $amountLost"
	netResult=$((amountWon-amountLost));
	if ((netResult>=0))
	then
		echo "Net Winnings = $netResult"
		monthCount=$((monthCount+30));
		read -p "If you Want to continue for new month enter 1 else anyother to exit :" choice
	else
		netResult=$((netResult* -1 ));
		echo "Net Loss = $netResult"
		choice=0;
	fi
done
