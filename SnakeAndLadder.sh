#!/bin/bash -x

START=0;
GOAL=100;

player1=$START;
counter=1;

declare -A player1Dictionary;

rollDie () {
	echo $(( RANDOM%6+1 ));
}

getOption () {
	echo $(( RANDOM%3 ));
}

checkForExactWinPos () {
	val=$(( $player1+$dieValue ));

	if [[ $val -gt $GOAL ]]
	then
		player1=$player1;
	else
		player1=$val;
	fi;
}

noPlayOption () {
	echo "NO PLAY";
}

ladderOption () {
	echo "LADDER";
	diffValue=$(( $GOAL-6 ));

	if [ $player1 -gt $diffValue ]
	then
		checkForExactWinPos;
	else
		player1=$(( $player1+$dieValue ));
	fi;
}

snakeOption () {
	echo "SNAKE";
	player1=$(( $player1-$dieValue ));
}

optionCheck () {
	dieValue=$1;
	result=$(getOption);

	case $result in
			0)
				noPlayOption;
				;;
			1)
				ladderOption;
				;;
			2)
				snakeOption;
				;;
			*)
				echo "INVALID OPTION";
				;;
	esac;
}

checkForNegativeValue () {
	value=$1;

	if [[ $value -lt $START ]]
	then
		player1=$START;
	fi;
}

snakeAndLadderMain () {
	while [[ $player1 -lt $GOAL ]]
	do
		dieValue=$(rollDie);
		optionCheck $dieValue;
		checkForNegativeValue $player1;
		player1Dictionary[$counter]="$dieValue""-""$result""-""$player1";
		(( counter++ ));
	done;

	echo "PLAYER 1 VALUE : " $player1;
	echo "DICTIONARY : " ${player1Dictionary[@]};
	echo "NUMBER OF TIMES DICE ROLLED : " ${#player1Dictionary[@]};
}

snakeAndLadderMain;
