#!/bin/bash

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# Set the terminal title to the current working directory.
PS1="\$(eyeballs)" # eyeballs
PS1+="\[\033]0;\w\007\]";
PS1+="\[${bold}\]";
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\] at ";
# if ldap common name is set show in place of actual hostname
test -s /etc/ldapcn && export LDAPCN=`cat /etc/ldapcn`
if [ -z "$LDAPCN" ]; then
	PS1+="\[${hostStyle}\]\h"; # hostname
else
	PS1+="\[${hostStyle}\]${LDAPCN}"; # ldap common name
fi
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\w"; # working directory
PS1+="\$(git_prompt \"${white} on ${violet}\")"; # Git repository details
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
PS2="\[${yellow}\] \[${reset}\]";

export PS1;
export PS2;

# vim: ft=sh