#!/bin/bash
# FONT COLORS
RED='\033[1;31m' # Error
YELLOW='\033[1;33m' # Warning
CYAN='\033[0;36m' # In progress
GREEN='\033[1;32m' # Success
NC='\033[0m' # No color
# SET BASE DIRECTORY
if [[ $(basename $PWD) == "tests" ]]; then
  BASE_DIR=$PWD;
else
  BASE_DIR=$HOME;
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
  pwd
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

# user_dirs=("logs" "repos" "setup")
# user_files=(
# check_and_create_dir "${user_dirs[@]}"

# echo
# echo -e "${CYAN}Installing base packages:${NC}"
# sudo apt update | tee -a $HOME/logs/setup_00_init.log
# echo
# echo -e "${CYAN}Scanning logs for errors ${NC}"
# grep -i (err|warn|hit) $HOME/logs/setup_00_init.logs | tee -a $HOME/logs/apt_update_errors.log
#sudo apt install build essential curl wget software-properties-common gpg net-tools gcc g++ perl make zip unzip git ufw openssl dkms ffmpeg ubuntu-restricted-extras python3 htop > $HOME/logs/setup_00_init.logs
#echo "Installation issues:"
#cat $HOME/logs/setup_00_init.logs | grep -i 'error\|warning\|fail\|warn\|err\|!'
date_string
echo $BASE_DIR
