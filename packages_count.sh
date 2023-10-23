#!/bin/bash

# Define the list of packages
packages=(
  neovim
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
  
  # Use yay to get package info and filter the "Depends On" line
  depends_on=$(yay -Qi "$package" | grep -i 'depends on' | cut -d ':' -f2-)
  
  # Check if any dependencies were found
  if [ -n "$depends_on" ]; then
    # Split the dependencies into an array and count them
    IFS=', ' read -ra dependencies <<< "$depends_on"
    dependency_count=${#dependencies[@]}
  else
    dependency_count=0
  fi
  
  # Print the number of dependencies
  echo "Number of dependencies: $dependency_count"
  echo
done

