#!/bin/bash

install_godot_desktop() {
        cp godot.desktop ~/.local/share/applications
        cp godot.desktop ~/Desktop/
        sudo chmod +x ~/Desktop/godot.desktop
        update-desktop-database
}

install_godot_icon() {
      if [ ! -f godot.png ]; then
                wget -O godot.png https://raw.githubusercontent.com/godotengine/godot/master/icon.png
      fi
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

if [ "$1" == "" ]; then
  printf "Use --help for usage\n"
  exit
elif [ "$1" == "--help" ]; then
  printf "[first arg] -- Godot binary\n[second arg] -- optional exec name"
elif [ ! -f "$1" ]; then
  printf "Could not find Godot binary $1\n"
else
  if [ "$2" == "" ]; then
    NAME="godot"
  else
    NAME="$2"
  fi
  printf "Install godot with name $NAME?"
  read -n1 ans
  if [ "$ans" != "y" ]; then
    printf "ans is not 'y', exiting...\n"
    exit
  fi
  sudo cp "$1" "/usr/bin/$NAME"
  create_godot_desktop "/usr/bin/$NAME"
  install_godot_desktop
  install_godot_icon
  printf "Installed!\n"
  rm godot.desktop
  rm godot.png
fi
