#!/usr/bin/env bash
if [ $EUID == 0 ]; then
  echo "This script must not be run as root"
  exit
fi

while true; do
  read -r -p "Do you want to switch your cathook repository into developer mode? y/n " yn
  case $yn in
  [Yy]*) break ;;
  [Nn]*) exit ;;
  *) echo "Please answer yes or no." ;;
  esac
done

# git setup
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch --unshallow
git submodule foreach --recursive 'git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"'
git submodule foreach --recursive 'git fetch --unshallow'

# config setup
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
configfile="$DIR/updater-preferences"
. config.shlib
cfg_write "$configfile" update_channel developer

while true; do
  read -r -p "Would you like to reset your repository to the origin/master branch? y/n " yn
  case $yn in
  [Yy]*) break ;;
  [Nn]*) exit ;;
  *) echo "Please answer yes or no." ;;
  esac
done

# more git setup
git reset --hard origin/master
git submodule foreach --recursive 'git reset --hard'
git submodule sync
git submodule update --init --recursive
