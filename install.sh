#!/bin/bash

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


echo -e -n "Would you like to use a custom Godot install path? "
read -n1 ans
if [ "$ans" == "y" ]; then
	echo -e -n "\nWhat path(absolute): "
	read pth
	if [ ! -d "$pth" ]; then
		echo -e -n "\n\nERROR: PATH $pth DOES NOT EXIST\n"
		echo -e -n "ABORT\n"
		exit
	fi
	INSTALLPATH=pth
else
	mkdir "/home/$USER/Godot"
	INSTALLPATH="/home/$USER/Godot"
	if [ ! -d "$INSTALLPATH" ]; then
		echo -e -n "\nERROR CREATING DIRECTORY $INSTALLPATH\n"
		echo -e -n "ABORT\n"
		exit
	fi
fi

cd "$INSTALLPATH"

ZIPNAME="Godot_v3.0-stable_x11.64.zip"
EXECNAME="Godot_v3.0-stable_x11.64"



wget "https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_x11.64.zip"
unzip $ZIPNAME
create_godot_desktop "$EXECNAME"
