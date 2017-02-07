#!/bin/bash
#
# BOFH Excuses generator
# Usage:
# ./bofexcuses.sh [OPTION]
#
# Options:
# -l - Add the path of a BOFHers excuses list
# -g - Will generate an excuse automatically
# -h - Show this help

ExcuseListPath=""
ExcuseArray=()
LineCount=0
Excuse=""

case "$1" in
	-l|--list)
		#Execute SelectExcuse
		clear

		ExcuseListPath=$2

		while read line ; do
		
			((LineCount++))
			ExcuseArray[$LineCount]="$line"
		
		done < $ExcuseListPath
	
		rand=$[ $RANDOM % $LineCount]
		Excuse=${ExcuseArray[$rand]}

		printf '%s\n'
		printf '%s\n' '-----------------------------------'
		printf '%s\n' '-BOFHers Excuse Selector/Generator-'
		printf '%s\n' '-----------------------------------'
		printf '%s\n'
		printf "Today Excuse N° $rand: \n"
		printf '%s\n' '' 
		
		echo $Excuse
		printf '%s\n' ''

		;;

	-g|--gen)
		#Execute Generate Excuse
		clear
		
		printf '%s\n' 'Generate Excuse'


 


		;;

	-h|--help)
		#Show Help
		clear
		printf '%s\n'
		printf '%s\n' '-----------------------------------'
		printf '%s\n' '-BOFHers Excuse Selector/Generator-'
		printf '%s\n' '-----------------------------------'
		printf '%s\n'
		printf '%s\n' 'Usage:'
		printf '%s\n' './bofexcuses.sh [OPTION]'
		printf '%s\n'
		printf '%s\n' 'Options:'
		printf '%s\n' '-l - Add the path of a BOFHers excuses list'
		printf '%s\n' '-g - Will generate an excuse automatically'
		printf '%s\n' '-h - Show this help'  
		printf '%s\n' 

		;;

	*)
		clear

		printf '%s\n'
		printf '%s\n' '-----------------------------------'
		printf '%s\n' '-BOFHers Excuse Selector/Generator-'
		printf '%s\n' '-----------------------------------'
		printf '%s\n'
		printf '%s\n' 'Use option "-h" to show the help'
		printf '%s\n'
	
		exit
		;;

esac


