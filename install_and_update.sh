#!/bin/bash

# Some escape codes to change colors.
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

# CONFIG: Name of final executable.
PROCESS_NAME="git_switcher";

# CONFIG: Change these values to change account informations.
MAIN_USERNAME="Your_Main_Username";
MAIN_EMAIL="Your_Main_Email";
MAIN_PASSWORD="Your_Main_Password";
SEC_USERNAME="Your_Sec_Username";
SEC_EMAIL="Your_Sec_Email";
SEC_PASSWORD="Your_Sec_Password";

# ONLY IN CASE OF UPDATING VALUES -> Decomment the value that you don't want to be changed.
# MAIN_USERNAME=$GIT_MAIN_ACCOUNT_USERNAME;
# MAIN_EMAIL=$GIT_MAIN_ACCOUNT_EMAIL;
# MAIN_PASSWORD=$GIT_MAIN_ACCOUNT_PASSWORD;
# SEC_USERNAME=$GIT_SEC_ACCOUNT_USERNAME;
# SEC_EMAIL=$GIT_SEC_ACCOUNT_EMAIL;
# SEC_PASSWORD=$GIT_SEC_ACCOUNT_PASSWORD;

PROFILE_FILENAME="";

# Check the existence of some files.
# Actually only BASH and Korn is supported.
if [ -a "${HOME}/.bash_profile" ]; then
  PROFILE_FILENAME="${HOME}/.bash_profile";
else
  if [ -a "${HOME}/.profile" ]; then
    PROFILE_FILENAME="${HOME}/.profile";
  else
    # Non supported terminal is used.
    echo -e "${RED}[ERROR] Current terminal is not supported!${RESET}" 1>&2;
    exit 1;
  fi
fi

GREP_PARAMETERS=$(
                    echo -   \
                         F  `# Interpret  PATTERN as a list of fixed strings, separated by newlines, any of which is to be matched.` \
                         q  `# Do not write anything to standard output. Exit immediately with zero status if any match isfound, even if an error was detected.`
                 );
# Delete spaces derived from a pretty formatting.
GREP_PARAMETERS=$(echo ${GREP_PARAMETERS} | sed 's/\ //g');

function setup_variables {
  echo -e "${GREEN}[+]${RESET} Starting setup of environment variables...";
  
  if ! grep $GREP_PARAMETERS "export GIT_MAIN_ACCOUNT_USERNAME=" $PROFILE_FILENAME; then
    echo "export GIT_MAIN_ACCOUNT_USERNAME=${MAIN_USERNAME}" >> ${PROFILE_FILENAME};
  else
    # -i.bu arg is used to make in-place change without temp file.
    sed -i.bu "s/GIT_MAIN_ACCOUNT_USERNAME=.*$/GIT_MAIN_ACCOUNT_USERNAME=${MAIN_USERNAME}/g" $PROFILE_FILENAME;
  fi
  echo -e "  ${GREEN}[+]${RESET} Updated GIT_MAIN_ACCOUNT_USERNAME.";

  if ! grep $GREP_PARAMETERS "export GIT_MAIN_ACCOUNT_EMAIL=" $PROFILE_FILENAME; then
    echo "export GIT_MAIN_ACCOUNT_EMAIL=${MAIN_EMAIL}" >> ${PROFILE_FILENAME};
  else
    sed -i.bu "s/GIT_MAIN_ACCOUNT_EMAIL=.*$/GIT_MAIN_ACCOUNT_EMAIL=${MAIN_EMAIL}/g" $PROFILE_FILENAME;
  fi
  echo -e "  ${GREEN}[+]${RESET} Updated GIT_MAIN_ACCOUNT_EMAIL.";

  if ! grep $GREP_PARAMETERS "export GIT_MAIN_ACCOUNT_PASSWORD=" $PROFILE_FILENAME; then
    echo "export GIT_MAIN_ACCOUNT_PASSWORD=${MAIN_PASSWORD}" >> ${PROFILE_FILENAME};
  else
    sed -i.bu "s/GIT_MAIN_ACCOUNT_PASSWORD=.*$/GIT_MAIN_ACCOUNT_PASSWORD=${MAIN_PASSWORD}/g" $PROFILE_FILENAME;
  fi
  echo -e "  ${GREEN}[+]${RESET} Updated GIT_MAIN_ACCOUNT_PASSWORD.";

  if ! grep $GREP_PARAMETERS "export GIT_SEC_ACCOUNT_USERNAME=" $PROFILE_FILENAME; then
      echo "export GIT_SEC_ACCOUNT_USERNAME=${SEC_USERNAME}" >> ${PROFILE_FILENAME};
  else
    sed -i.bu "s/GIT_SEC_ACCOUNT_USERNAME=.*$/GIT_SEC_ACCOUNT_USERNAME=${SEC_USERNAME}/g" $PROFILE_FILENAME;
  fi
    echo -e "  ${GREEN}[+]${RESET} Updated GIT_SEC_ACCOUNT_USERNAME.";

  if ! grep $GREP_PARAMETERS "export GIT_SEC_ACCOUNT_EMAIL=" $PROFILE_FILENAME; then
      echo "export GIT_SEC_ACCOUNT_EMAIL=${SEC_EMAIL}" >> ${PROFILE_FILENAME};
  else
    sed -i.bu "s/GIT_SEC_ACCOUNT_EMAIL=.*$/GIT_SEC_ACCOUNT_EMAIL=${SEC_EMAIL}/g" $PROFILE_FILENAME;
  fi
  echo -e "  ${GREEN}[+]${RESET} Updated GIT_SEC_ACCOUNT_EMAIL.";

  if ! grep $GREP_PARAMETERS "export GIT_SEC_ACCOUNT_PASSWORD=" $PROFILE_FILENAME; then
    echo "export GIT_SEC_ACCOUNT_PASSWORD=${SEC_PASSWORD}" >> ${PROFILE_FILENAME};
  else
    sed -i.bu "s/GIT_SEC_ACCOUNT_PASSWORD=.*$/GIT_SEC_ACCOUNT_PASSWORD=${SEC_PASSWORD}/g" $PROFILE_FILENAME;
  fi
  echo -e "  ${GREEN}[+]${RESET} Updated GIT_SEC_ACCOUNT_PASSWORD.";

  # Save the updates.
  source ${PROFILE_FILENAME};
  echo -e "${GREEN}[+]${RESET} All environment variables setted with success!";
}

# Print logo :)
clear;
echo "   ____ _ _   ____          _ _       _               "
echo "  / ___(_) |_/ ___|_      _(_) |_ ___| |__   ___ _ __ "
echo " | |  _| | __\___ \ \ /\ / / | __/ __| '_ \ / _ \ '__|"
echo " | |_| | | |_ ___) \ V  V /| | || (__| | | |  __/ |   "
echo "  \____|_|\__|____/ \_/\_/ |_|\__\___|_| |_|\___|_|   "
echo -e "                                     CODED BY: Thot-02\n\n"

# Check if git_switcher is already inside system binaries.
if [ -f "/usr/local/bin/${PROCESS_NAME}" ]; then
  echo -e "\n\nStarting updating process...\n";
  setup_variables;
  echo -e "\nUpdating process terminated.\n";
  exit 0;
else
  # Install git_switcher.
  echo -e "\n\nStarting installation process...\n";
  chmod +x "${PROCESS_NAME}.sh";
  cp "${PROCESS_NAME}.sh" "/usr/local/bin/${PROCESS_NAME}";
  echo -e "${GREEN}[+]${RESET} Added to system binaries, now you can call it simply by \"git_switcher\".";
  setup_variables;
  echo -e "\nInstallation process terminated.\n";
  exit 0;
fi
