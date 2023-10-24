#!/bin/bash

packages=(
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
  xf86-input-synaptics
  brightnessctl
  network-manager-applet
  thunar
  feh
  bc
  picom-git
  polkit
  gnome-keyring
  polkit-gnome
  xdg-user-dirs
  lxappearance
  gtk2
  pavucontrol-git
  pamixer
 )

 extra_packages=(
   lxappearance
   adwaita-dark
   adwaita-cursors
   adwaita-icon-theme
   )

 #Note ttf-icomoon-feather is not installed please install that font manually aur package is having some issues
specific_fonts=(
  ttf-fira-code
  ttf-comic-sans
  ttf-iosevka-nerd
  )

# This section downloads fornts needed (Indian, Chinese, Japanese, Korean, and MS fonts for working in Libre office which includes TimesNewRoman)
complete_fonts=(
  sanskrit-fonts
  adobe-source-han-sans-otc-fonts
  ttf-ms-fonts
  noto-fonts-emoji
  )

apps=(
  brave-bin
  neovim
  qbittorrent
  libre-office-still
  telegram-desktop
  kate
  code
  mpv
)

sddm_themes() {
  sudo pacman -S plasma-framework5
}

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

### Install all of the complete fonts pacakges ####
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the Complete fonts? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    for SOFTWR in ${complete_fonts[@]}; do
        install_software $SOFTWR 
    done
fi

### Install all of the specific fonts pacakges ####
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the Specific fonts? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    for SOFTWR in ${specific_fonts[@]}; do
        install_software $SOFTWR 
    done
fi

### Install all of the above pacakges ####
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the required apps? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    for SOFTWR in ${apps[@]}; do
        install_software $SOFTWR 
    done
fi

read -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
  echo -e "Copying config files..."

    # check for existing config folders and removing 
    for DIR in bspwm sxhkd rofi polybar alacritty backgrounds dunst
    do 
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then 
            echo -e "$CAT - Config for $DIR located, deleting it."
            rm -rf $DIRPATH
            echo -e "$COK - Deleted $DIR."
        fi
        cp -R config/* ~/.config/
    done
else
  echo -e "Haven't copyied any files"
fi

# Copy mouse Gestures
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to configure mouse settings whill be helpfull to use Gestures? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
  echo -e "Copying Mouse settings..."
  MOSFILE=/etc/X11/xorg.conf.d/30-touchpad.conf
  sudo rm $MOSFILE
  echo "Copying Touchpad Gestures File to $MOSFILE "
  sleep 2
  sudo cp extras/100-touchpad.conf $MOSFILE
else
  echo -e "Something went wrong please copy the touchpad file manually"
fi

# Copy the SDDM theme
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to use SDDM Sweet Themes? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
  sddm_themes
  echo -e "Copying SDDM Themes..."
  echo -e "Setting up the login screen."
  sudo cp -R extras/Sweet /usr/share/sddm/themes/
  sudo chown -R $USER:$USER /usr/share/sddm/themes/Sweet
  sudo mkdir /etc/sddm.conf.d
  echo -e "[Theme]\nCurrent=Sweet" | sudo tee -a /etc/sddm.conf.d/10-theme.conf
  WLDIR=/usr/share/xsessions
  if [ -d "$WLDIR" ]; then
      echo -e "$WLDIR found"
  else
      echo -e "$WLDIR NOT found, creating..."
      sudo mkdir $WLDIR
  fi 
  # stage the .desktop file
  sudo cp extras/bspwm.desktop /usr/share/xsessions/
else
  echo -e "Something went wrong please copy the SDDM Theme manually"
fi

start_services
echo -e "Done with the script reboot to enjoy the bspwm experience"
