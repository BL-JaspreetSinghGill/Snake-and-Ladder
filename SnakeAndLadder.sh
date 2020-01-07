#!/bin/bash -x

START=0;
GOAL=100;
NUMBER_OF_PLAYERS=2;

assigningValuesToPlayers () {
	NUMBER_OF_PLAYERS=$1;

	for (( i=1; i<=$NUMBER_OF_PLAYERS; i++ ))
   do
      (( player$i=$START ));
		(( counter$i=1 ));
		declare -A playerDictionary$i;
   done;
}

rollDie () {
	echo $(( RANDOM%6+1 ));
}

getOption () {
	echo $(( RANDOM%3 ));
}

checkForExactWinPos () {
	val=$(( $(( player$p )) +$dieValue ));

	if [[ $val -gt $GOAL ]]
	then
		(( player$p=$(( player$p )) ));
	else
		(( player$p=$val ));
	fi;
}

noPlayOption () {
	echo "NO PLAY";
}

ladderOption () {
	echo "LADDER";
	diffValue=$(( $GOAL-6 ));

	if [ $(( player$p )) -gt $diffValue ]
	then
		checkForExactWinPos;
	else
		(( player$p=$(( $((player$p ))+$dieValue )) ));
	fi;
}

snakeOption () {
	echo "SNAKE";
	(( player$p=$(( $((player$p ))-$dieValue )) ));
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
		(( player$p=$START ));
	fi;
}

storeInDictionary () {
	(( playerDictionary$p[$(( counter$p ))]="$dieValue""$result""$(( player$p ))" ));
	(( counter$p=$((counter$p))+1 ));
}

singlePlayerGame () {
	dieValue=$(rollDie);
	optionCheck $dieValue;
	checkForNegativeValue $(( player$p ));
	storeInDictionary;

	echo "PLAYER $p VALUE : " $(( player$p ));
	#echo "NUMBER OF TIMES DICE ROLLED : " ${#playerDictionary$p[@]};
}

multiPlayerGame () {
	while [[ $player1 -lt $GOAL && $player2 -lt $GOAL ]]
	do
		p=1;
		singlePlayerGame;
		p=2;
		singlePlayerGame;
	done;
}

displayDictionaryElements () {
	echo "DICTIONARY 1 VALUES: " ${playerDictionary1[@]};
	echo "DICTIONARY 2 VALUES: " ${playerDictionary2[@]};
}

displayResult () {
	echo "PLAYER 1 VALUE:  " $player1;
   echo "PLAYER 2 VALUE:  " $player2;

	if [[ $player1 -eq $GOAL ]]
	then
		echo "PLAYER 1 WIN";
	else
		echo "PLAYER 2 WIN";
	fi;
}

snakeAndLadderMain () {
	assigningValuesToPlayers $NUMBER_OF_PLAYERS;

	multiPlayerGame;
	displayDictionaryElements;
	displayResult;
}

snakeAndLadderMain;
