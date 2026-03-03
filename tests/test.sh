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
  local DUMMIES=()
  if [[ ! $(pwd) == $BASE_DIR ]]; then
    # else echo error, log to syslog and exit
    ERROR_MESSAGE="The installation directory cannot be accessed. Please verify that you have permission to continue or try again later"
    ERROR+=($ERROR_MESSAGE)
    echo -e "${RED}$ERROR_MESSAGE${NC}"
    logger -t $(basename "$0") -p user.err $ERROR_MESSAGE
    exit 1
  else
    NOW_STR="$(date_string)"
    mkdir "$NOW_STR""_folder"
    echo "This is a test file" | tee "$NOW_STR""_folder/""$NOW_STR""_file.txt"
    ls "$NOW_STR""_folder/""$NOW_STR""_file.txt"
    
    ## to check if current directory is writeable
    ## create and delete dummy folder
    ## create and delete dummy file
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