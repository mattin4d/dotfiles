# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactivly, don't do anything
[ -z "$PS1" ] && return

if [[ -d "$HOME/bin" ]] && [[ ! "$PATH" =~ "$HOME/bin" ]];
then
	export PATH=$HOME/bin:$PATH
fi

case ${TERM} in
	xterm*|rxvt*|gnome*|konsole*)
		export TERM=xterm-256color
		export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
		;;
	screen*)
		export TERM=screen-256color
		export PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
		;;
esac

source_dir()
{
	local dir="$1"
	if [[ -d $dir ]];
	then
		local conf_file
		for conf_file in "$dir"/*;
		do
			if [[ -f $conf_file && $(basename $conf_file) != 'README' ]];
			then
				source "$conf_file"
			fi
		done
	fi
}

source_dir ~/.bash.d/local/before
source_dir ~/.bash.d
source_dir ~/.bash.d/local/after

# vim: ft=sh
