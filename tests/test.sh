# FONT COLORS
RED='\033[1;31m' # Error
YELLOW='\033[1;33m' # Warning
CYAN='\033[0;36m' # In progress
GREEN='\033[1;32m' # Success
NC='\033[0m' # No color

# VARIABLES
USER_DIRS=("logs" "repos" "setup")
USER_FILES=("/logs/init.log" "/logs/errors.log")
BASE_DIR="$HOME"
PREV_DIR="$(pwd)"
ERRORS=()
WARNINGS=()

# FUNCTIONS
enable_bash_customisations() {
  if [[ -f "$HOME/.bashrc" ]]; then
    if [[ "$(ask_confirmation 'Install bash aliases and helper functions to your .bashrc?')" == "y" ]]; then
      echo
      echo "install customisations"
    else
      echo
      return 0
    fi
  fi
}

set_base_dir() { # Set base directory to either $HOME (production) or test_home (development)
  if [[ ! $(basename $PWD) == "uboontup" ]]; then
    BASE_DIR=$PWD/test_home;
  fi
  cd $BASE_DIR
}

check_base_dir() { # Check if pwd is correct directory
  cd ..
  if [[ ! $(pwd) == $BASE_DIR ]]; then
    # else echo error, log to syslog and exit
    ERROR_MESSAGE="The installation directory cannot be accessed. Please verify that you have permission to continue or try again later"
    ERRORS+=($ERROR_MESSAGE)
    echo "${ERRORS[@]}"
    echo -e "${RED}ERRORS:${NC}"
    printf "%s\n" "${ERRORS[@]}"
    logger -t $(basename "$0") -p user.err $ERROR_MESSAGE
    exit 1
  else
    NOW_STR="$(date_string)"
    echo "before temp"
    ls
    mkdir "$NOW_STR""_folder"
    echo "after temp"
    ls
    echo "This is a test file" | tee "$NOW_STR""_folder/""$NOW_STR""_file.txt"
    if [[ -d "$NOW_STR" && -f "$NOW_STR""_folder/""$NOW_STR""_file.txt" ]]; then
      echo -e "${GREEN}Directory $NOW_STR""_folder is writable${NC}"
      rm -r "$NOW_STR""_folder"
      echo after rm
      ls
      if [[ -d "$NOW_STR""_folder" ]]; then
        echo -e "${YELLOW}Temporary files could not be removed${NC}"
        echo
        if [[ "$(ask_confirmation 'Do you want to proceed with installation? anyway')" != "y" ]]; then
          echo "${RED}Aborting installation. Goodbye!${NC}"
          exit 1
        fi
      fi
    else
      ERROR_MESSAGE="The base directory is not writable"
      ERRORS+=($ERROR_MESSAGE)
      echo -e "${RED}ERRORS:${NC}"
      printf "%s\n" "${ERRORS[@]}"
      logger -t $(basename "$0") -p user.err $ERROR_MESSAGE
      exit 1
    fi
  fi
}

date_string() {
  echo $(date +%Y%m%d%H%M%S)
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

enable_bash_customisations
# Execute actions
set_base_dir
pwd
check_base_dir
pwd
# check_and_create_dir "${USER_DIRS[@]}"
# backup_folder "test" "bkp_"


cd $PREV_DIR
if [[ $PREV_DIR == $(pwd) ]]; then
  echo -e "${GREEN}Thank you for using Uboontup. We hope you had a nice experience.${NC}"
  exit 0;
else
  echo -e "${RED}We are sorry, but something went wrong.${NC} File an issue or contact us on ${YELLOW}Github${NC} for further assistance."
  exit 1
fi