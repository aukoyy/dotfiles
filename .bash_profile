# The following echo statement is for demo purposes only. Remove at will
echo 'FROM BASH_PROFILE';

# This statement checks for a .bashrc file and loads it if it exists. 
# It allows for aliases and configurations to be declared once in .bashrc
# and loaded into both this profile specific terminal and sub terminals like '$bash'
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi


# nvm stuff:
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
