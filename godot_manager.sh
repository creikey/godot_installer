#!/bin/bash

exec=godot.x11.tools.64

install_godot_icon() {
	if [ ! -f godot.png ]
	then
		echo "--- Pulling Godot icon..."
		wget -O godot.png http://watfile.com/images/WatFile.com_data_2015_08_Godot-Engine.png
	else
		echo "-!- Godot icon already exists!"
	fi
	echo "--- Putting image into pixmaps"
	sudo cp godot.png /usr/share/pixmaps
}

install_godot_desktop() {
	cp godot.desktop ~/.local/share/applications
	cp godot.desktop ~/Desktop/
	sudo chmod +x ~/Desktop/godot.desktop
	update-desktop-database
}

uninstall_godot_desktop() {
	echo "-!- Uninstalling Godot"
	if [ -f ~/Desktop/godot.desktop ]
	then
		rm ~/Desktop/godot.desktop
	fi
	if [ -f /usr/share/pixmaps/godot.png ]
	then
		sudo rm /usr/share/pixmaps/godot.png
	fi
	if [ -f ~/.local/share/applications/godot.desktop ]
	then
		rm ~/.local/share/applications/godot.desktop
	fi
}

create_godot_desktop() {
	echo -e -n "[Desktop Entry]\n" > godot.desktop
	echo -e -n "Type=Application\n" >> godot.desktop
	echo -e -n "Name=Godot Game Engine\n" >> godot.desktop
	echo -e -n "GenericName=Godot\n" >> godot.desktop
	echo -e -n "Coment=An open source game engine\n" >> godot.desktop
	echo -e -n "Exec=" >> godot.desktop
	echo -e -n "$1\n" >> godot.desktop
	echo -e -n "Icon=godot\n" >> godot.desktop
	echo -e -n "Terminal=false\n" >> godot.desktop
	echo -e -n "Categories=IDE;\n" >> godot.desktop
}


download_godot_zip() {
	if [ -f Godot_v2.1.4-stable_x11.64.zip ]
	then
		echo "--- Found previous zip file..."
	else
		wget "https://downloads.tuxfamily.org/godotengine/2.1.4/Godot_v2.1.4-stable_x11.64.zip"
		echo "--- Finished downloading zip file!"
	fi
}

if [ "$1" == "-u" ]
then
	uninstall_godot_desktop
	echo -e -n "Delete all files?(Y/n)"
	read -n1 -r an
	if [ "$an" == "Y" ]
	then
		rm godot.desktop
		rm -r godot_exec
		rm godot.png
		rm "Godot_v2.1.4-stable_x11.64.zip"
	else
		echo "-!- Not uninstalling other files..."
	fi
	exit
fi

echo -e -n "Would you like to install godot?"
read -n1 -r an


if [ "$an" == "y" ]
then
	echo "Installing Godot..."
	# download_godot_zip
	if [ ! -d "godot_exec" ]
	then
		mkdir "godot_exec"
	fi
	if [ ! -f "godot_exec/$exec" ]
	then
		if [ ! -f "$exec" ]
		then
			echo "ERROR: NO EXEC FOUND"
			exit
		fi
		mv "$exec" "godot_exec"
		# unzip Godot_v2.1.4-stable_x11.64.zip
		# mv "Godot_v2.1.4-stable_x11.64" "godot_exec"
	fi
	cd godot_exec
	exec_dir=$(pwd)
	exec_dir="$exec_dir/$exec"
	cd ..
	if [ ! -f godot.png ] || [ ! -f /usr/share/pixmaps/godot.png ]
	then
		install_godot_icon
	fi
	if [ ! -f godot.desktop ] || [ ! -f ~/.local/share/applications/godot.desktop ] || [ ! -f ~/Desktop/godot.desktop ]
	then
		create_godot_desktop "$exec_dir"
		install_godot_desktop
	fi
	echo "!!! Done"
fi
