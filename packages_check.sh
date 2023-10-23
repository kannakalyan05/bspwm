#!/bin/bash

# Define the list of packages
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
  thunar
)

# Loop through the packages and check their dependencies
for package in "${packages[@]}"; do
  echo "Checking dependencies for package: $package"
  
  # Use Yay to list the dependencies and count them
  dependency_count=$(yay -Qi "$package" | grep -o 'Depends On: ' | wc -l)
  
  # Print the number of dependencies
  echo "Number of dependencies: $dependency_count"
  echo
done

