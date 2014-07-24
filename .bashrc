# ~/.bashrc: executed by bash for non-login shells.

# Exports.
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/share:/usr/local/share/npm/bin:/Users/balint/scripts:$PATH"
export EDITOR=vi
export TERM=xterm-256color
export CLICOLOR=true

# Bash colors.
export color_none='\e[0m'
export color_white='\e[1;37m'
export color_black='\e[0;30m'
export color_blue='\e[0;34m'
export color_light_blue='\e[1;34m'
export color_green='\e[0;32m'
export color_light_green='\e[1;32m'
export color_cyan='\e[0;36m'
export color_light_cyan='\e[1;36m'
export color_red="\e[0;31m"
export color_light_red='\e[1;31m'
export color_purple='\e[0;35m'
export color_light_purple='\e[1;35m'
export color_brown='\e[0;33m'
export color_yellow='\e[1;33m'
export color_gray='\e[0;90m'
export color_light_gray='\e[0;37m'

# Include aliases.
source $HOME/.aliases
source $HOME/.aliases_project

## Configure the bash prompt.

# Date piece. It's not used at the moment, but let's keep it here anyway. It could be useful.
DATE_PIECE="\[${color_gray}\]\$(date '+%H:%M:%S')\[${color_none}\]"

# Path piece.
PATH_PIECE="\$(echo \${PWD/\$HOME/\~} | sed -E 's/.*((\/.*){'\$(((\$(tput cols) - 85) / 10))'})/..\1/')"

# Git piece.
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/git-completion.bash 
  
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PIECE='$(__git_ps1 " \[$color_light_purple\](%s)\[$color_none\]")'
else
  GIT_PIECE=''
fi

default_hostname='candy'
if [ $HOSTNAME == $default_hostname ]; then
  color_user_and_hostname=${color_yellow}
else
  color_user_and_hostname=${color_red}
fi

# Bash prompt.
export PS1="${DATE_PIECE} \[$color_user_and_hostname\]\u\[${color_none}\]@\[$color_user_and_hostname\]\H \[${color_green}\]${PATH_PIECE}\n\[${color_light_blue}\]▶${GIT_PIECE:-""}\[${color_none}\] "


# SSH alias to fix TERM problem.
function ssh {
  local old=$TERM
  TERM=xterm-color
  `which ssh` $@
  TERM=$old
}

# Make locate use Spotlight.
function locate {
  local root=$1
  shift
  mdfind -onlyin $root "kMDItemDisplayName == '$@'wc"
}

