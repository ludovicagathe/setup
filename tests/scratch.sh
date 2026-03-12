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

enable_bash_customisations() { # Check .bashrc and source from customisation files
  local BASHRC_FILE="$HOME/.bashrc_test"
  local LINE="^source [\w\/\.]*bash_aliases_and_functions[.]*$"
  local INSERT=""
  local TEMP=$(cat "$BASHRC_FILE" |grep "$LINE")
  if [[ -f "$BASHRC_FILE" ]]; then
    if [[ ! -z "$TEMP" ]]; then
      #echo $(cat "$BASHRC_FILE" | grep "$lINE")
      echo -e "${YELLOW}Bash customisations found${NC}"
      return 0
    fi
    if [[ "$(ask_confirmation 'Install bash aliases and helper functions to your .bashrc?')" == "y" ]]; then
      echo
      INSERT="\n## Bash customisations (v0.1): aliases and functions\n$LINE"
      echo -e "$INSERT" >> "$BASHRC_FILE"
    else
      echo
      return 0
    fi
  fi
}


# documentation
enable_bash_customisations