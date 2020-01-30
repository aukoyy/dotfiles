# dotfiles

This is a collection of my preferences so as to allow quick setup and continuity between machines I use for development

# Usage
cd into this folder
run `source bootstrap.sh`

This will copy the needed text into the systems bash files and point to the files in this folder.


### Inspiration:
https://github.com/mathiasbynens/dotfiles

## Costemizing the shell:
### Special characters:
\h	the hostname up to the first .
\n	newline
\s	the name of the shell
\t	the current time in 24-hour format
\u	the username of the current user
\w	the current working directory (whole path)
\W	the basename of the current working directory (only current folder)

### Color Setting:
$(tput setaf 166): sets color 166. Look up 256 color chart for colors
$(tput sgr0): resets formatting