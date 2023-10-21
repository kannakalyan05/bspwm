read -rep $'[\e[1;33mACTION\e[0m] - Would you like to replace files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
  echo -e "Replacing config files..."
  # check for existing config folders and removing 
  for DIR in bspwm sxhkd rofi polybar alacritty backgrounds dunst nitrogen
  do 
    PWD=$(pwd)
    PWDFILE=$PWD/$DIR
    DIRPATH=~/.config/$DIR
    if [ -d "$PWDFILE" ]; then 
      echo -e "Config for $PWDFILE located, deleting it."
      rm -rf $PWDFILE
      echo -e "Deleted $PWDFILE."
      cp -R $DIRPATH $PWDFILE
      echo "Completed copying file from $DIRPATH to $PWDFILE"
    fi
  done
else
  echo -e "Haven't copyied any files"
fi
