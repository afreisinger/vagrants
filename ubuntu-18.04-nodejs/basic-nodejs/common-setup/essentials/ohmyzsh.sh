#!/bin/bash

source "$SCRIPT_DIR/bash.d/colors" # Get some color codes for printing
# Detect machine
unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     MACHINE=Linux;;
  Darwin*)    MACHINE=Mac;;
  CYGWIN*)    MACHINE=Cygwin;;
  MINGW*)     MACHINE=MinGw;;
  *)          MACHINE="UNKNOWN:${unameOut}"
esac

#echo $MACHINE
echo -e $(dark_yellow "...installing oh my zsh")
# Installs .oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # Installs Oh my ZSH with Homebrew (Mac)
  
  if [[ $MACHINE == "Mac" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  # Installs Oh my ZSH with Linux
  if [[ $MACHINE == "Linux" ]]; then
    sudo apt install zsh -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
else
  echo -e $(green "...oh my zsh is installed")

fi

# Zsh plugin manager (handles oh-my-zsh, etc)
# https://github.com/zplug/zplug
echo -e $(dark_yellow "...installing zplug")
if [ ! -d "$HOME/.zplug" ]; then
  sh -c "$(curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh)"

else 
  echo -e $(green "...zplug is installed")
fi


# Assumes default ZSH installation
#ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Installs plugins
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Fix permissions
#chmod 700 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
