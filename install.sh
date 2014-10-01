#!/usr/bin/env bash

# installation paths
HOME_BIN="$HOME/.bin/bash-brew-service"
SERVICE="$HOME_BIN/service"
SERVICE_LIST="$HOME_BIN/service-list"
SERVICE_INSTALL="$HOME_BIN/service-install"
SERVICE_REMOVE="$HOME_BIN/service-remove"

# let user know what we're doing
printf "[info] Installing brew-service to $HOME_BIN\n"

# if install target exists
if [ -d "$HOME_BIN" ] ; then
  # and we're not in the install target
  if [ "$(pwd)" != "$HOME_BIN" ] ; then
    while true; do
      read -p "[warning] $HOME_BIN exists, overwrite? [yes/no] " YN
      case $YN in
          [Yy]* ) printf "[info] Removing directory $HOME_BIN\n"; rm -rf "$HOME_BIN"; break;;
          [Nn]* ) printf "[error] Installation aborted by user\n"; exit;;
          * ) printf "[error] Please answer 'yes' or 'no'\n";;
      esac
    done
  else
    # can't install to target from target...
    printf "[error] Please install from outside of target dir\n"
    printf "[error] Installation aborted\n"
    exit
  fi
fi

# recreate the dir
printf "[info] Creating install directory $HOME_BIN\n"
mkdir -p "$HOME_BIN"

# copy all the scripts
printf "[info] Installing scripts to $HOME_BIN\n"
cp service "$SERVICE"
cp service-list "$SERVICE_LIST"
cp service-install "$SERVICE_INSTALL"
cp service-remove "$SERVICE_REMOVE"

# make scripts executable
chmod u+x "$SERVICE" "$SERVICE_LIST" "$SERVICE_INSTALL" "$SERVICE_REMOVE"

# check if the dir is in their path
if [ "$(grep -c "$HOME_BIN" "$HOME/.bash_profile")" == "0" ] ; then
  # add it to their path via .bash_profile
  printf "[info] Adding install directory to your \$PATH in $HOME/.bash_profile\n"
  printf "\n# brew-services executable dir\n" >> "$HOME/.bash_profile"
  printf "export PATH=\"\$PATH:$HOME_BIN\"\n" >> "$HOME/.bash_profile"
else
  printf "[info] Existing path found in $HOME/.bash_profile, skipping\n"
fi

# all done, source their profile
source "$HOME/.bash_profile"
printf "[info] Installation complete!\n"
