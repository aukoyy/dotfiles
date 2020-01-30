# The following statement is for demo purposes only. Remove at own will.
echo 'FROM BASHRC'

# Git aliases
alias gs='git status'
alias gco='git checkout'
alias gb='git branch'
alias glg='git lg -10'
alias cpg='cat package.json | grep'

# Costemizing the shell:
# Special characters:
: '
\h	the hostname up to the first .
\n	newline
\s	the name of the shell
\t	the current time in 24-hour format
\u	the username of the current user
\w	the current working directory (whole path)
\W	the basename of the current working directory (only current folder)
'

: ' 
Color Setting:
$(tput setaf 166): sets color 166. Look up 256 color chart for colors
$(tput sgr0): resets formatting
'

# Colors and formatting :
orange=$(tput setaf 166);
yellow=$(tput setaf 228);
green=$(tput setaf 71);
white=$(tput setaf 15);
bold=$(tput bold);
reset=$(tput sgr0);

# Set Formatting:
PS1="\[${bold}\]\n";
PS1+="\[${orange}\]\u";
PS1+="\[${white}\] at ";
PS1+="\[${yellow}\]\h";
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\W";
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]";
export PS1;

# can I have PS2 and more??
