#!/bin/bash

# Installs the install script, as well as compiles godot

install_path="/home/$USER/Godot"

manager_script="godot_manager.sh"

if [ ! -f "$manager_script" ]
then
	echo "ERROR: NO MANAGER SCRIPT"
	exit
fi

echo "Installing to $install_path..."

mkdir -p "$install_path"

cp "$manager_script" "$install_path"

cd "$install_path"

git clone https://github.com/godotengine/godot.git

cd godot

sudo apt-get install build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev \
    libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libfreetype6-dev libssl-dev libudev-dev \
    libxrandr-dev xserver-xorg-dev libxext-dev libxi-dev

scons platform=x11

cp bin/godot.x11.tools.64 ..
