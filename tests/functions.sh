#!/bin/bash
# FONT COLORS
RED='\033[1;31m' # Error
YELLOW='\033[1;33m' # Warning
CYAN='\033[0;36m' # In progress
GREEN='\033[1;32m' # Success
NC='\033[0m' # No color
# SET BASE DIRECTORY
if [[ $(basename $PWD) == "setup" ]]; then
  BASE_DIR=$HOME;
else
  BASE_DIR=$PWD;
fi
PREV_DIR=$(pwd)
cd $BASE_DIR

# FUNCTION DEFINITIONS
# RETURN A TIMESTAMP - DATE STRING WITH TIME
date_string() {
  echo $(date +%Y%m%d%H%M%S)
}

# ASK FOR CONFIRMATION
ask_confirmation() {
  if [[ -z "$1" ]]; then
    PROMPT="Confirm (y/n): ";
  else
    PROMPT="$1"$'\nConfirm (y/n): '
  fi
  read -p "$PROMPT" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
    then
      printf "y";
    else
      printf "n";
  fi
}

# CHECK AND CREATE REQUIRED DIRECTORIES
check_and_create_dir () {
  for user_dir in "$@"; do
    if [[ -d "$BASE_DIR/$user_dir" ]]; then
      echo -e "$BASE_DIR/$user_dir ${RED}already exits${NC}" | tee -a $BASE_DIR/logs/setup_00_init.log
      if [[ $(ask_confirmation "Back up folder contents?") == 'y' ]]; then
        echo
        BKP_STR="bkp_$(date_string)"
        echo "$BASE_DIR"
        echo "$BKP_STR"
        mkdir "$BASE_DIR/$BKP_STR"
        mv -i "$BASE_DIR/$user_dir/*" "$BASE_DIR/$BKP_STR"
        mv -i "$BASE_DIR/$BKP_STR" "$BASE_DIR/$user_dir/"
      else
        echo
      fi
    else
      mkdir "$BASE_DIR/$user_dir"
      echo -e "$BASE_DIR/$user_dir ${GREEN}created${NC}"
    fi
  done
}

# BACK UP A FOLDER WITH POSSIBILITY TO EXCLUDE PREFIX
backup_folder() {
  if [[ ! -z $2 ]]; then
    EXCLUDE="$2*"
  else
    EXCLUDE=""
  fi

  # list backup folder found

  # force excluded backup
  echo "$1"
  ls "$1"
  if [[ -d "$1" ]]; then
    TO_BKP=$(ls -A -I "$EXCLUDE" "$1")
    echo "${TO_BKP[@]}"
    return 0
  else
    echo -e "${RED}Folder does not exist${NC}"
    return 1
  fi
}

check_and_create_file() {
  echo test
}

# VARIABLES
user_dirs=("logs" "repos" "setup")
user_files=("/logs/init.log" "/logs/errors.log")
# check_and_create_dir "${user_dirs[@]}"
backup_folder "test" "bkp_"


cd $PREV_DIR