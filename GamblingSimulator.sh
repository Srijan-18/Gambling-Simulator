#!/bin/bash -x

echo "Welcome To Gambling Simulator"
BET_LOSE=0;
BET_WIN=1;
dailyAmount=100;
betAmount=1;

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

betChance=$((RANDOM%2));
dailyAmount=$(betResult $betChance);
