#!/bin/bash

printf "Uninstalling...\n"
rm ~/.local/share/applications/godot.desktop
rm ~/Desktop/godot.desktop
sudo rm /usr/share/pixmaps/godot.png
sudo rm /usr/bin/godot
