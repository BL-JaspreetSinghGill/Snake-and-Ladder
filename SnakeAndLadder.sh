#!/bin/bash -x

START=0;
GOAL=100;
player1=0;

rollDie () {
	echo $(( RANDOM%6+1 ))
}

snakeAndLadderMain () {
	echo $player1;
	rollDie;
}

snakeAndLadderMain;
