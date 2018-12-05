#
#   \`.|\..----...-'`   `-._.-'_.-'`
#   /  ' `         ,       __.--'
#   )/' _/     \   `-_,   /
#   `-'" `"\_  ,_.-;_.-\_ ',     fsc/as
#       _.-'_./   {_.'   ; /
#     {_.-``-'         {_/
#
#   https://github.com/stringlytyped/dotfiles
#
#   BASHRC
#   Configures non-login interactive shells
#

# Paths
# -------------------------------------------------------------- #

PATH="$HOME/bin:/usr/local/opt/postgresql@9.6/bin:$(go env GOPATH)/bin:$(brew --prefix coreutils)/libexec/gnubin:$(brew --prefix findutils)/libexec/gnubin:$(brew --prefix grep)/libexec/gnubin:$PATH"
MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$(brew --prefix findutils)/libexec/gnuman:$(brew --prefix grep)/libexec/gnuman:$MANPATH"

export PATH MANPATH

# Other exports
# -------------------------------------------------------------- #

export EDITOR='nano'

export LC_CTYPE="utf-8"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Configure macOS' built-in ls command to print colours
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Set options
# -------------------------------------------------------------- #

# Prevent files from being accidentally overwritten when using a > redirect
# See http://www.linuxhowtos.org/Tips%20and%20Tricks/Protecting%20files%20with%20noclobber.htm
set -o noclobber

# Enable pyenv shims
# -------------------------------------------------------------- #

# See https://github.com/pyenv/pyenv

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Powerline prompt
# -------------------------------------------------------------- #

# See https://github.com/powerline/powerline

powerline_script=~/.pyenv/versions/3.6.5/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh

if [[ -f "$powerline_script" ]]; then
	powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  # shellcheck source=/Users/JS/.pyenv/versions/3.6.5/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
  source "$powerline_script"
fi

# Aliases
# -------------------------------------------------------------- #

alias ls='ls --color=auto -F'
# F: add classifiers to end of entries

alias ll='ls --color=auto -lFh'
# l: use long-listing format
# F: add classifiers to end of entries
# h: print file sizes in human-readable form

alias git='hub'
# https://hub.github.com/

alias weather='weather --units ca'
# https://github.com/genuinetools/weather

alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias edit='open -a "Visual Studio Code"'
alias reload='bind -f ~/.inputrc; source ~/.bash_profile'
alias server='python3 -m http.server'
alias pgstart='pg_ctl -D /usr/local/var/postgres start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop'
alias cd..='cd ..'
alias cd~='cd ~'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias ..1='cd ..'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'
alias ~='cd ~'