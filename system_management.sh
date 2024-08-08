#!/bin/bash
source ./file-managment.sh

function fileManagment(){
	options=(Create Copy Move Reaname Delete Search Exit)
	PS3="Choose Option: "
	select op in ${options[@]}; do
		case $REPLY in
			1) create;;
			2) copy;;
			3) move;;
			4) rename;;
			5) delete;;
			6) search;;
			7) exit 0;;
			*) echo "Invalid: Please choose from menu"
				fileManagment;;
		esac
	done
}


while true;
do
	fileManagment
done
