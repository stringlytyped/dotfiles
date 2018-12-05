#! /usr/bin/env bash

# Array of dotfiles to be symlinked in the home directory
files=(bashrc bash_profile inputrc gitconfig gitignore)

# Array of Homebrew formulae that the dotfiles depend on
brew_formulae=(coreutils darksky-weather hub)

# Array of Mac applications and corresponding Homebrew casks that the dotfiles depend on
apps=("Visual Studio Code" "Sourcetree")
casks=("vscode" "sourcetree")

# Get the path to the dotfiles directory
# See https://www.ostricher.com/2014/10/the-right-way-to-get-the-directory-of-a-bash-script/
source_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# yn()
# Ask a yes/no question.
# Argument $1 = question
# Sets variable "response" to either "y" or "n".
yn() {
  read -rp "$* " response
  case $response in
    [yY] | [yY][Ee][Ss] )
      response="y"
      ;;
    [nN] | [nN][Oo] )
      response="n"
      ;;
    *)
      echo "Invalid input. Try again:"
      yn "$*"
      ;;
  esac
}

# Check whether Homebrew is installed
if ! hash brew 2>/dev/null; then
  yn "Homebrew (https://brew.sh) was not found on your system. As a result, this install script won't be able to check whether or not the other dependencies are installed. Would you like to continue anyway (y/n)?"
  if [ $response = n ]; then
    exit 1
  fi
else
  # Check whether all required Homebrew formulae are installed
  for formula in "${brew_formulae[@]}"; do
    if ! brew ls --versions "$formula" &>/dev/null; then
      yn "$formula was not found on your system. Would you like to run \"brew install $formula\" to install it (y/n)?"
      if [ $response = y ]; then
        brew install "$formula"
      fi
    fi
  done
fi

# Check whether all required Mac apps are installed
for i in ${!apps[*]}; do
  if ! [[ -d "/Applications/${apps[i]}.app" ]]; then
    yn "${apps[i]} was not found on your system. Would you like to run \"brew cask install ${casks[i]}\" to install it (y/n)?"
    if [ $response = y ]; then
      brew cask install "${casks[i]}"
    fi
  fi
done

# TODO: check for existence of powerline & pyenv
# if ! pip show powerline-status &>/dev/null; then
# fi

# Create a symbolic link for the powerline config directory in ~/.config/powerline
if [[ -d "$HOME/.config/powerline" ]]; then
  # shellcheck disable=SC2088
  yn "~/.config/powerline/ already exists. Do you want to overwrite it (y/n)?"
  if [ $response = y ]; then
    rm -r "$HOME/.config/powerline"
    ln -sf "$source_dir/powerline" "$HOME/.config/powerline"
  fi
else
  ln -sf "$source_dir/powerline" "$HOME/.config/powerline"
fi

# Prompt user for Git configuration values
echo "Let's configure Git!"
read -rp "  Enter your name (e.g. \"Jane Smith\"): " response
git config -f "$source_dir/gitconfig" user.name "$response"
read -rp "  Enter your email (e.g. \"jsmith@example.com\"): " response
git config -f "$source_dir/gitconfig" user.email "$response"
echo "Done configuring Git :)"

# Create a symbolic link in the user's home directory for each dotfile
for file in "${files[@]}"; do
  if [[ -f "$HOME/.$file" ]]; then
    # shellcheck disable=SC2088
    yn "~/.$file already exists. Do you want to overwrite it (y/n)?"
    if [ $response = n ]; then
      continue
    fi
  fi
  ln -sf "$source_dir/$file" "$HOME/.$file"
done

# Load newly-installed bash config
# shellcheck source=./bashrc
source ~/.bashrc