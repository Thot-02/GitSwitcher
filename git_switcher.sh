#!/bin/bash

# Some escape codes to change colors.
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
RESET='\033[0m'

# Change git config with the values of MAIN environment variables.
function set_main {
  git config ${SCOPE} user.name $GIT_MAIN_ACCOUNT_USERNAME;
  git config ${SCOPE} user.email $GIT_MAIN_ACCOUNT_EMAIL;
  git config ${SCOPE} user.password $GIT_MAIN_ACCOUNT_PASSWORD;
  echo -e "${GREEN}[+]${RESET} MAIN ACCOUNT ${GREEN}->${RESET} $GIT_MAIN_ACCOUNT_USERNAME${GREEN} loaded with success to ${RESET}${SCOPE/--/}${GREEN} scope!${RESET}";
  exit 0;
}

# Change git config with the values of SECondary environment variables.
function set_sec {
  git config ${SCOPE} user.name $GIT_SEC_ACCOUNT_USERNAME;
  git config ${SCOPE} user.email $GIT_SEC_ACCOUNT_EMAIL;
  git config ${SCOPE} user.password $GIT_SEC_ACCOUNT_PASSWORD;
  echo -e "${GREEN}[+]${RESET} SECONDARY ACCOUNT ${GREEN}->${RESET} $GIT_SEC_ACCOUNT_USERNAME${GREEN} loaded with success to ${RESET}${SCOPE/--/}${GREEN} scope!${RESET}";
  exit 0;
}

# Check if all environment variables are currently set and give some instructions.
function check_env_var {
  if [ -z "${GIT_MAIN_ACCOUNT_USERNAME}" ] || [ -z "${GIT_MAIN_ACCOUNT_EMAIL}" ] || [ -z "${GIT_MAIN_ACCOUNT_PASSWORD}" ] || \
     [ -z "${GIT_SEC_ACCOUNT_USERNAME}" ] ||  [ -z "${GIT_SEC_ACCOUNT_EMAIL}" ] || [ -z "${GIT_SEC_ACCOUNT_PASSWORD}" ]; then
    echo -e "${RED}\n[ERROR] Make sure to set these environment variables before run:${RESET}" 1>&2;
    echo "  GIT_MAIN_ACCOUNT_USERNAME=\"Your_Main_Username\"" 1>&2;
    echo "  GIT_MAIN_ACCOUNT_EMAIL=\"Your_Main_Email\"" 1>&2;
    echo "  GIT_MAIN_ACCOUNT_PASSWORD=\"Your_Main_Password\"" 1>&2;
    echo "  GIT_SEC_ACCOUNT_USERNAME=\"Your_Sec_Username\"" 1>&2;
    echo "  GIT_SEC_ACCOUNT_EMAIL=\"Your_Sec_Email\"" 1>&2;
    echo "  GIT_SEC_ACCOUNT_PASSWORD=\"Your_Sec_Password\"" 1>&2;
    exit 1;
  fi
}

# Check if the program is runned inside a git directory.
# USED ONLY if scope is setted to --local.
function check_git_directory {
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}[ERROR] You have to be in a git directory to change account!${RESET}" 1>&2;
    exit 1;
  fi
}

function tip_and_exit {
  echo -e "${RED}[ERROR] Wrong parameter inserted!\n${YELLOW}See: git_switcher -h/--help.${RESET}" 1>&2;
  exit 1;
}

# Basic information menu.
function help {
  clear;
  echo "   ____ _ _   ____          _ _       _               "
  echo "  / ___(_) |_/ ___|_      _(_) |_ ___| |__   ___ _ __ "
  echo " | |  _| | __\___ \ \ /\ / / | __/ __| '_ \ / _ \ '__|"
  echo " | |_| | | |_ ___) \ V  V /| | || (__| | | |  __/ |   "
  echo "  \____|_|\__|____/ \_/\_/ |_|\__\___|_| |_|\___|_|   "
  echo -e "                                     CODED BY: Thot-02\n\n"

  echo "Usage: git_switcher <[-h] [-l] [-g] [-s] [-main] [-sec]>  <[-main] [-sec]>";
  echo -e "\n\nFirst argument:";
  echo "  -h, --help                  Show this help message and exit.";
  echo "  -l, --local                 Set modify to local scope.";
  echo "  -g, --global                Set modify to global scope.";
  echo "  -s, --system                Set modify to system scope.";
  echo "  -main, --main_account       Set main account as principal in LOCAL scope.";
  echo "  -sec, --sec_account         Set sec account as principal in LOCAL scope.";
  echo -e "\nSecond argument:";
  echo "  -main, --main_account       Set main account as principal.";
  echo -e "  -sec, --sec_account         Set sec account as principal.\n";
  exit 0;
}

# Control if "git_switcher" is called without arguments.
if [[ -z $1 && -z $2 ]]; then
  help;
fi

# Control if short selector for main or sec is selected and make some controls.
if [ $1 == "-main" ] || [ $1 == "--main_account" ] || [ $1 == "-sec" ] || [ $1 == "--sec_account" ]; then
  check_git_directory;
fi

# Set default git scope to local.
SCOPE="--local"

# Check all possibility for the first argument.
case $1 in
  -l|--local)
    check_git_directory;
    ;;
  -g|--global)
    SCOPE="--global";
    ;;
  -s|--system)
    SCOPE="--system";
    ;;
  -main|--main_account)
    check_env_var;
    set_main;
    ;;
  -sec|--sec_account)
    check_env_var;
    set_sec;
    ;;
  -h|--help)
    help;
    ;;
  *)
    tip_and_exit;
esac

# Recheck the environment variables, since they are checked only if first parameter is -main or -sec.
check_env_var;

case $2 in
  -main|--main_account)
    set_main;
    ;;
  -sec|--sec_account)
    set_sec;
    ;;
  *)
    tip_and_exit;
esac
