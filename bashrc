#!/bin/bash
# My Awesome bashrc file

function header {
	# I should be able to call this from the shell script, myheader
	local black='\e[0;30m'		# Black - Regular
	local red='\e[0;31m'		# Red
	local green='\e[0;32m'		# Green
	local yellow='\e[0;33m'		# Yellow
	local blue='\e[0;34m'		# Blue
	local purple='\e[0;35m'		# Purple
	local cyan='\e[0;36m'		# Cyan
	local white='\e[0;37m'		# White

	local mytty=$(tty | sed 's/\/dev\///')
	local startdate=$(date +"%a %b %d")
	local starttime="${startdate}: $(date +%H:%M)"
	local info="${cyan}-${blue}-(${green}$USER@$HOSTNAME:$mytty${blue})-${cyan}"
	local infolen=$(echo $info | sed 's/\\e[^m]*m//g')
	echo -ne $info
	local fillin=$(($COLUMNS-${#infolen}-5-${#starttime}))
	local i=0
	while [ $i -lt $fillin ]
	do
		echo -ne "-"
		let i=i+1
	done
	echo -ne "${blue}-($starttime)-${cyan}-"
	echo -ne "${black}\n"
}
export XENVIRONMENT=~/.Xdefaults
export EDITOR=/usr/bin/vim

function myprompt {
	# This sets what my prompt looks like.
	# Greatly enhanced Feb 28 2012
	local cgreen='\[\e[4;32m\]'
	local cblue='\[\e[0;34m\]'
	local cred_bold='\[\e[1;31m\]'
	local cred='\[\e[0;31m\]'
	local creset='\[\e[m\]'
	local psclock="[${cblue}\[\a\]\@${creset}]"
	if [ $UID == 0 ]; then
		# Set root color
		local psname="${cred_bold}\h${creset}"
		local psindic="${cred}#${creset}"
	else
		# Set user color
		local psname="${cgreen}\h${creset}"
		local psindic="\$"
	fi
	if [ -n "$SSH_CLIENT" ]; then
		PS1="${psclock}[${cred}SSH${creset}@${psname} \W]\$ "
	else
		PS1="${psclock}[${psname} \W]${psindic} "
	fi
}
myprompt


# Old Prompts
# Non-color prompt
#PS1='[\h \W]\$ '
# Color Prompt
#PS1='[\[\e[0;32m\]\h\[\e[0m\] \W]\$ '

#export PROMPT_COMMAND='[[ $curdir != $PWD ]] && ls; curdir=$PWD'

# Might fix a couple Term problems
shopt -s checkwinsize

# Don't overwrite existing file when output is redirected
set -o noclobber

# Fix for screen/tmux escape sequence
stty ek

case "$TERM" in
	screen-256color)
		export PROMPT_COMMAND='echo -ne "\033]2;$(basename "${DIRSTACK}")\007"'
		;;
esac
# History settings
HISTFILESIZE=100000000
HISTSIZE=100000
export HISTCONTROL=ignoredups

# Extra Bash Completions
complete -cf sudo
complete -cf man
complete -cf which
complete -cf pacman
source /usr/share/git/completion/git-completion.bash
if [[ -e /usr/bin/pacman-color ]]; then
	# this might not be working?
	complete -o default -o nospace -F pacman pacman-color
fi
if [[ -e /usr/bin/yaourt ]]; then
	complete -cf yaourt
fi

# Exports

#function export_path
#{
	#local array[0]="$HOME/bin"
	#local array[1]="/usr/lib/colorgcc/bin"
	#local array[2]="/home/vernon/arm/toolchain/gcc-4.6/bin"
	#local array[3]="/usr/local/bin"
	#local array[4]="/home/vernon/source/avast/bin"
	#local array[5]="/opt/ruby1.8/bin"
	#local array[6]="/home/vernon/programming/blitz/blitz-bin"
	#for i in ${array[@]}; do
		#if [[ -d $i ]]; then
			#export PATH=$i:"$PATH"
		#fi
	#done
#}
#export_path
# This one colorizes the output of grep
export GREP_COLOR="1;32"
set show-all-if-ambiguous on
# Add ~/bin to PATH
#if [ -d $HOME/bin ]; then export PATH="$HOME/bin:$PATH"; fi

# man colors
export LESS="i -R"
export LESS_TERMCAP_mb=$(printf "\e[1;36m")
export LESS_TERMCAP_md=$(printf "\e[32m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;47;30m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[0;36m")

# Default dir colors
#eval `dircolors -b`
# Custom dir colors
if [[ -e $HOME/.dir_colors ]]; then
	eval $(dircolors $HOME/.dir_colors)
elif [[ -x /home/vernon/.dir_colors ]]; then
	eval $(dircolors /home/vernon/.dir_colors)
fi

# ALIAS/BIND
# Keybindings
# Key combo	Action
# ALT-t		open a new xterm instance at current dir
#bind '"\et"':"\"xterm -wf & \C-m\" "
# ALT-s		append sudo, move to end of line
#bind '"\es"':"\"\C-asudo \C-e\" "
# ALT-m		append man, move to end of line
#bind '"\em"':"\"\C-aman \C-e\" "

# Grand old list of aliases

# Color Additions
#alias esudo='sudo -E '
#alias sudo='sudo -E'
alias sudoUnalias="$(which sudo)"
if [[ -e /usr/bin/pacman-color ]]; then
	alias pacman='pacman-color'
fi
alias dfc='dfc -d'
alias diff='colordiff -up'

# Directory aliases
alias dir='/usr/bin/ls -F'
alias ls='ls --color=auto --group-directories-first --si -F'
alias pd='pushd'
alias bd='popd'
alias cdl='ls $3; cd $3'
# Directory Movement
alias ..='cd ..'
alias ...='cd ../..'

# Command modifications
alias nautilus='nautilus --no-desktop'
alias df='df -h'
alias sfeh='feh -FZ --hide-pointer'
alias clyde='yaourt -a'
alias grep='grep --color=auto'
alias a2ps='a2ps -R --columns=1 -M letter'
# Grep for less or whatever
alias cgrep='grep --color=always'
# Grep for piping stuff
alias findgrep='find . -type f -exec grep -iHn --color=always '
alias ncgrep='grep --color=never'
alias time='/usr/bin/time -f "%e real\n%U user\n%S system\n%E elapsed\n%P CPU"'
alias tarbackup='tar -p --numeric-owner -cJf'
alias tarbackupv='tar -p --numeric-owner -cvJf'
alias tmux='tmux -2'
alias tmuxl='tmux list-sessions'
alias tmuxn='tmux new-session -s'
alias tmuxat='tmux attach -t'
alias tmuxa='tmux attach'
alias tmuxsnum='tmux list-sessions | egrep -c "^"'

# gcc addons
alias gcc-gtk='gcc `pkg-config --cflags --libs gtk+-2.0`'
alias g++-gtk='g++ `pkg-config --cflags --libs gtkmm-3.0`'
alias gcc-gtk-thread='gcc `pkg-config --cflags --libs gtk+-2.0 --libs gthread-2.0` -Wall'
alias gcc-all='gcc `pkg-config --cflags --libs gtk+-2.0 --libs gthread-2.0` -I /usr/include/cairo -L /usr/lib -lcairo'

# Look of disapproval
alias ಠ_ಠ='echo "Look of Disapproval: U+0CA0"'

# Safety Features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

# Enable completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

#~/.Xdefaults
#Xcursor.theme:		Oxygen_White
#URxvt.cursorColor:	black
#URxvt.background:	white
#URxvt.foreground:	black
#URxvt.scrollBar:	off
#URxvt.perl-ext:		default,matcher
#URxvt.urlLauncher:	/usr/bin/firefox
#URxvt.matcher.button:	1
#URxvt.depth:		32
#URxvt*background:	rgba:0000/0000/0000/cccc
#XTerm*metaSendsEscape:	true
#xterm*bellIsUrgent:	true

#~/.bash_profile
#source /home/vernon/.bashrc
#if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
#  startx
#  logout
#fi


#if [[ $(expr length "$(basename "$(pwd)")") -ge $(($COLUMNS/2)) ]]; then
#	PS1='[\[\e[0;36m\]\h ...\[\e[0;30m\]]\$ '
#else
#	PS1='[\[\e[0;36m\]\h \W\[\e[0;30m\]]\$ '
#fi
header
