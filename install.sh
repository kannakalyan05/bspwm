#!/bin/bash

packages=(
  network-manager-applet
  dunst
  libnotify
  rofi
  polybar-git
  alacritty
  sxhkd
  bspwm
  sddm
  pipewire
  wireplumber
  lxappearance
  xf86-input-synaptics
  pw-volume
  brightnessctl
  adwaita-icon-theme
  adwaita-cursors
  adwaita-dark
  ttf-jetbrains-mono-nerd-font
  ttf-comic-sans
  ttf-iosevka-nerd
  ttf-nerd-fonts-symbols
)

# function that will test for a package and if not found it will attempt to install it
install_software() {
  # First lets see if the package is there
  if yay -Q $1 &>> /dev/null ; then
    echo -e "$1 is already installed."
  else
    # no package found so installing
    echo "Now installing $1 ."
    yay -S $1
  fi
}

start_services() {
  echo "Starting services."
  sudo systemctl enable sddm
  sudo systemctl enable NetworkManager
}

# clear the screen
clear

### Install all of the above pacakges ####
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    for SOFTWR in ${packages[@]}; do
        install_software $SOFTWR 
    done
fi


read -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
  echo -e "Copying config files..."

    # check for existing config folders and removing 
    for DIR in bspwm sxhkd rofi polybar alacritty backgrounds dunst nitrogen
    do 
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then 
            echo -e "$CAT - Config for $DIR located, deleting it."
            rm -rf $DIRPATH &>> $INSTLOG
            echo -e "$COK - Deleted $DIR."
        fi

        cp -R config/* ~/.config/
    done
  start_services
else
  echo -e "Haven't copyied any files"
fi
