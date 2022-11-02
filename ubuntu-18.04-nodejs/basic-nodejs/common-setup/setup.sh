#!/bin/bash
# Run to setup with ./setup.sh
BASH_DIR="${HOME}/.bash.d"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -e #exit on error

pushd "$SCRIPT_DIR" > /dev/null #The pushd command saves the current working directory in memory so it can be returned to at any time


source "$SCRIPT_DIR/bash.d/colors" # Get some color codes for printing



source "$SCRIPT_DIR/essentials/ohmyzsh.sh" #Installs Oh my ZSH and zplug


# read local environment variables, like auth tokens
if [ -e "${HOME}/.secret" ]; then
  source "${HOME}/.secret"
fi

if [ ! -e "$BASH_DIR" ]; then
  mkdir "${BASH_DIR}"
fi

if [ ! -e "$HOME/bin" ]; then
  mkdir "${HOME}/bin"
fi

rm -rf "$HOME"/.bash_completion.d 2>/dev/null
ln -s "$SCRIPT_DIR"/bash_completion.d "$HOME"/.bash_completion.d 

if [ -e "$HOME/.bash_profile" ]; then
    echo "We don't use .bash_profile to avoid trouble. Renaming to .bash_profile.bak"
    mv ~/.bash_profile{,.bak}
fi

echo -e $(blue "Linking directories")


source "$SCRIPT_DIR/link-dotfiles.sh" #Installs Oh my ZSH and zplug

#echo -e $(green ""...$SCRIPT_DIR"/profile -> "$HOME"/.profile")
#echo -e $(green ""...$SCRIPT_DIR"/bashrc -> "$HOME"/.bashrc")
#echo -e $(green ""...$SCRIPT_DIR"/gitconfig -> "$HOME"/.gitconfig")
#echo -e $(green ""...$SCRIPT_DIR"/gitignore -> "$HOME"/.gitignore")
#echo -e $(green ""...$SCRIPT_DIR"/tmux.conf -> "$HOME"/.tmux.conf")
#echo -e $(green ""...$SCRIPT_DIR"/zsh/zshrc -> "$HOME"/.zshrc")

#ln -sf "$SCRIPT_DIR"/profile "$HOME"/.profile
#ln -sf "$SCRIPT_DIR"/bashrc "$HOME"/.bashrc
#ln -sf "$SCRIPT_DIR"/gitconfig "$HOME"/.gitconfig
#ln -sf "$SCRIPT_DIR"/gitignore "$HOME"/.gitignore
#ln -sf "$SCRIPT_DIR"/pystartup "$HOME"/.pystartup
#ln -sf "$SCRIPT_DIR"/tmux.conf "$HOME"/.tmux.conf


# Zsh
#ln -sf "$SCRIPT_DIR"/zsh/zshrc "$HOME"/.zshrc

echo -e $(blue "Create needed dirs")
# create needed dirs
[[ ! -e "$HOME/.tmux" ]] && mkdir "$HOME/.tmux";
[[ ! -e "$HOME/.tmux/plugins" ]] && mkdir "$HOME/.tmux/plugins";
[[ ! -e "$HOME/.tmux/plugins/tpm" ]] && git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm 

echo -e $(green "...$HOME/.tmux")
echo -e $(green "...$HOME/.tmux/plugins")
echo -e $(green "...$HOME/.tmux/plugins/tpm")

echo -e $(blue "Linking tmux project settings")

# copy tmux project settings
for file in "$SCRIPT_DIR"/tmux/*; do
  ln -sf "$file" "${HOME}/.tmux/"
  echo -e $(green "...${HOME}/.tmux/""$(basename $file)" "->" "$file")
done

echo -e $(blue "Linking bash.d")
for file in "$SCRIPT_DIR"/bash.d/*; do
  ln -sf "$file" "${BASH_DIR}"/
  echo -e $(green "...$file" "->""${BASH_DIR}/")
done


printf "$(blue "Finished common setup")\n\n"
popd > /dev/null