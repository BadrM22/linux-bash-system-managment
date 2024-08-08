#/bin/bash

function create(){
	read -p "Enter file or directory name: " name
	read -p "Enter location: " location
	
	if [ -e $name ]; then
		echo "file or directory already exists"
		return 1
	fi
	if [ ! -w $location ]; then
		echo "Permission denied can not write files in this directory"
		return 1
	fi
	if [ -d $name ]; then
		mkdir -p  $location/$name
	else
		touch $location/$name
	fi
}

function copy(){
	read -p "Enter file or directory name: " name
	read -p "Enter file or directory location: " location
	read -p "Enter directory destination: " destination
	if [ ! -w $destination ]; then
		echo "Permission denied can not write files/directories in this directory"
		return 1
	fi
	
	if [ -e "$destination/$name" ]; then
		echo "file/directory already exists"
		return 1
	fi
	
	if [ ! -e "$location" ]; then
		echo "directory does not exist"
		return 1
	fi
	if [ -d "$name" ]; then
		mkdir $destination/$name
	else
		touch $destination/$name
	fi
}

function rename(){
	read -p "Enter file old name: " oldName
	read -p "Enter file new name: " newName
	if [ ! -e "$oldName" ]; then
	       	echo "file/directory does not exist"
       		return 1
	fi
	read -p "are you sure? (y/n): " confirm
	if [ "$confirm" ]; then
		mv "$oldName" "$newName"
	else
		exit 0
	fi

}

function move(){
	read -p "Enter file/directory name: " file
	read -p "Enter file/directory location: " location
	read -p "Enter file/directory destination: " destination
	if [ ! -e "$location/$file" ]; then
		echo "File/directory does not exist"
		return 1
	fi
	if [ ! -d "$destination" ]; then
		echo "destination directory does not exist"
		return 1
	fi
	if [ ! -w "$destination" ]; then
		echo "Permission denied don't have permission to write in this directory"
		return 1
	fi
	mv "$location/$file" "$destination/$file"
}

function delete(){
	read -p "Enter file/directory name: " file
	read -p "Enter file/directory location: " location
	if [ ! -e "$location/$file" ]; then
		echo "File/directory does not exist"
		return 1
	fi
	rm -rf "$location/$file"
}
function search(){
	read -p "Enter path to file/directory you want to search for: " file
	echo "$file"
}
function mode(){
	echo "Change mode: $0 [-c mode] [-u user] [-g group] file"
	echo " -c mode: set file permissions(e.g., -c 755)"
	echo " -u user: change file owner(e.g., -u john)"
	echo " -g group: change file group(e.g, -g users)"
	echo "file: The file to modify"
	while getopts "c:u:g" opt; do
		case $opt in
			c) mode="$OPTARG";;
			u) user="$OPTARG";;
			g) group="$OPTARG";;
			\?) echo "Invalid options: -$OPTARG"
				exit 1;;
			:) echo "Options -$OPTARG reaquires an argument."
				exit 1;;
		esac
	done
	file="$OPTARG"
}
