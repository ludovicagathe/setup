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

date_string() {
  echo $(date +%Y%m%d%H%M%S)
}

check_and_create_dir () {
  for user_dir in "$@"; do
    if [[ -d "$BASE_DIR/$user_dir" ]]; then
      echo -e "$BASE_DIR/$user_dir ${RED}already exits${NC}" | tee -a $BASE_DIR/logs/setup_00_init.log 
    else
      mkdir "$BASE_DIR/$user_dir"
      echo -e "$BASE_DIR/$user_dir ${GREEN}created${NC}"
    fi
  done
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
