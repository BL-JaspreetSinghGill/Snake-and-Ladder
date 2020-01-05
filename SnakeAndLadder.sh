#!/bin/bash -x

START=0;
GOAL=100;
player1=$START;

rollDie () {
	echo $(( RANDOM%6+1 ))
}

getOption () {
	echo $(( RANDOM%3 ));
}

optionCheck () {
	dieValue=$1;
	result=$(getOption);

	case $result in
			0)
				echo "NO PLAY";
				;;
			1)
				echo "LADDER";
				player1=$(( $player1+$dieValue ));
				;;
			2)
				echo "SNAKE";
				player1=$(( $player1-$dieValue ));
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
		echo "PLAYER 1 : " $player1;
	done;

	echo "PLAYER 1 VALUE : " $player1;
}

snakeAndLadderMain;
