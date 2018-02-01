#!/bin/bash

install_godot_icon() {
        if [ ! -f godot.png ]
        then
                echo "--- Pulling Godot icon..."
                wget -O godot.png https://raw.githubusercontent.com/godotengine/godot/master/icon.png
        else
                echo "-!- Godot icon already exists!"
        fi
        echo "--- Putting image into pixmaps"
        sudo cp godot.png /usr/share/pixmaps
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


echo -e -n "Would you like to use a custom Godot install path? "
read -n1 ans
echo
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
	INSTALLPATH="/home/$USER/Godot"
	if [ -d "$INSTALLPATH" ]; then
		echo -e -n "WARNING: PREVIOUS GODOT INSTALL FILE FOUND AT $INSTALLPATH\n"
		ls "$INSTALLPATH"
		echo -e -n "Delete it? "
		read -n1 ans
		echo
		if [ "$ans" == "y" ]; then
			echo -e -n "\nDeleting...\n"
			rm -r "$INSTALLPATH"
			if [ -d "$INSTALLPATH" ]; then
				echo "ERROR DELETING: COULD NOT DELETE $INSTALLPATH"
				echo "ABORT"
				exit
			fi
		else
			echo "Using previous location..."
		fi
	fi
	mkdir "/home/$USER/Godot"
	if [ ! -d "$INSTALLPATH" ]; then
		echo -e -n "\nERROR CREATING DIRECTORY $INSTALLPATH\n"
		echo -e -n "ABORT\n"
		exit
	fi
fi

cd "$INSTALLPATH"

ZIPNAME="Godot_v3.0-stable_x11.64.zip"
EXECNAME="Godot_v3.0-stable_x11.64"

if [ -f "$ZIPNAME" ]; then
	echo "ERROR: PREVIOUS ZIP FILE FOUND"
	echo -e -n "Use it? "
	read -n1 ans
	echo
	if [ "$ans" == "n" ]; then
		echo -e -n "Delete it? "
		read -n1 ans
		echo
		if [ "$ans" == "n" ]; then
			echo "ERROR: ILLOGICAL LOGIC"
			echo "ABORT"
			exit
		fi
	else
		echo "Using..."
	fi
else
	wget "https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_x11.64.zip"
fi

unzip "$ZIPNAME"
if [ ! -f "$EXECNAME" ]; then
	echo "ERROR: CANNOT FIND EXEC NAME"
	echo "ABORT"
fi
echo "Creating desktop..."
create_godot_desktop "$EXECNAME"
echo "Installing icon..."
install_godot_icon








