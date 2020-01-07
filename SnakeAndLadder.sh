#!/bin/bash -x

START=0;
GOAL=100;

decideNumberOfPlayers () {
	read -p "ENTER THE NUMBER OF PLAYERS : " NUMBER_OF_PLAYERS;

	echo $NUMBER_OF_PLAYERS;
}

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

singlePlayerGame () {
	while [[ $(( player$p )) -lt $GOAL ]]
	do
		dieValue=$(rollDie);
		optionCheck $dieValue;
		checkForNegativeValue $(( player$p ));
		(( playerDictionary$p[$(( counter$p ))]="$dieValue""$result""$(( player$p ))" ));
		(( counter$p=$((counter$p))+1 ));
	done;

	echo "PLAYER $p VALUE : " $(( player$p ));
	#echo "NUMBER OF TIMES DICE ROLLED : " ${#playerDictionary$p[@]};
}

multiPlayerGame () {
	for (( p=1; p<=$NUMBER_OF_PLAYERS; p++ ))
	do
		singlePlayerGame;
	done;
}

displayDictionaryElements () {
	echo "DICTIONARY 1 VALUES: " ${playerDictionary1[@]};
	echo "DICTIONARY 2 VALUES: " ${playerDictionary2[@]};
}

displayResult () {
	min=10000000;
	playerName=0;

	if [ $NUMBER_OF_PLAYERS -eq 1 ]
	then
		echo "PLAYER 1 WIN";
	else
		for (( k=1; k<=$NUMBER_OF_PLAYERS; k++ )) {
			if [[ $((counter$k)) -lt $min ]]
			then
				min=$((counter$k));
				playerName=$k;
			fi;
		}

		echo "PLAYER $playerName WIN";
	fi;
}

snakeAndLadderMain () {
	NUMBER_OF_PLAYERS=$(decideNumberOfPlayers);
	assigningValuesToPlayers $NUMBER_OF_PLAYERS;

	multiPlayerGame;
	displayDictionaryElements;
	displayResult;
}

snakeAndLadderMain;
