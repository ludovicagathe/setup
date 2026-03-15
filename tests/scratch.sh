#!/bin/bash
# Scratchpad for testing functionalities

# FONT COLORS
RED='\033[1;31m' # Error
YELLOW='\033[1;33m' # Warning
CYAN='\033[0;36m' # In progress
GREEN='\033[1;32m' # Success
NC='\033[0m' # No color

documentation() {
  echo "-----------------------------------------------------"
  echo "|               Welcome to Uboontup !               |"
  echo "|                                                   |"
  echo "|      An easy way to get Ubuntu up and running     |"
  echo "|               for some serious work               |"
  echo "-----------------------------------------------------"

}

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

compare_versions() {
  if [[ -z "$1" || -z "$2" ]];then
    echo -e "${RED}Invalid version arguments supplied${NC}"
    exit 1
  fi
  if [[ "$1" =~ ^[v]?[0-9]+\.[0-9]+\.[0-9]+[\-]?[\-\.0-9a-zA-Z]?+$  && "$2" =~ ^[v]?[0-9]+\.[0-9]+\.[0-9]+[\-]?[\-\.0-9a-zA-Z]?+$ ]]; then
    echo "valid versions supplied"
  else
    echo -e "${RED}Invalid version arguments supplied${NC}"
    exit 1
  fi
}

enable_bash_customisations() { # Check .bashrc and source from customisation files
  local BASHRC_FILE="$HOME/.bashrc_test"
  local CUSTOM_FILE='../custom/uboontup_aliases_and_functions'
  local RX='source .*bash_aliases_and_functions'
  local LINE='source ../bash_aliases_and_functions'
  local INSERT=""
  local VERSION=$(sed -n 's/.*\(## Version: \)\([v\.0-9]*\).*/\2/p' "$CUSTOM_FILE")
  local TEMP=$(cat "$BASHRC_FILE"|grep "$RX")
  echo $VERSION
  local SOURCES=$(sed -n "/$RX/p" "$BASHRC_FILE"|wc -l)
  echo $SOURCES
  # search for source line in .bashrc
  # if exists:
    # get custom file version
    # if version != current
      # propose to replace lines and file
  # else
    # propose to install

  if [[ -f "$BASHRC_FILE" ]]; then
    if [[ ! -z "$TEMP" ]]; then
      echo -e "${YELLOW}Bash customisations found${NC}"
  #     return 0
  #   fi
  #   if [[ "$(ask_confirmation 'Install bash aliases and helper functions to your .bashrc?')" == "y" ]]; then
  #     echo
  #     INSERT="\n## Bash customisations (v0.1): aliases and functions\n$LINE"
  #     echo -e "$INSERT" >> "$BASHRC_FILE"
  #   else
  #     echo
  #     return 0
    fi
  else
    echo -e "${RED}.bashrc file not found${NC}"
    echo "Please check that you have Bash installed and configured correctly"
    echo "error logged and exit"
  fi
}

erase_line() {
  local BASHRC_FILE="$HOME/.bashrc_test"
  local RX='source .*bash_aliases_and_functions'
  local LINE='source ../bash_aliases_and_functions'
  local INSERT=""
  local TEMP=$(cat "$BASHRC_FILE"|grep "$RX")
  sed -n "/$RX/p" "$BASHRC_FILE"
}


# documentation
#enable_bash_customisations
compare_versions "v1.0.0" "v1.0.0"