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

# Initialize variables to keep track of total dependencies and package dependencies
total_dependencies=0
declare -A package_dependencies

# Loop through the packages and check their dependencies
for package in "${packages[@]}"; do
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
  
  # Add the dependency count to the total
  total_dependencies=$((total_dependencies + dependency_count))
  
  # Store the package name and its dependency count
  package_dependencies["$package"]=$dependency_count
done

# Print the total number of dependencies at the end
echo "Total number of dependencies for all packages: $total_dependencies"

# Print the list of packages and their respective dependencies
for package in "${!package_dependencies[@]}"; do
  echo "$package: ${package_dependencies[$package]}"
done

