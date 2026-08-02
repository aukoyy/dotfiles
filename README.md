# dotfiles and terminal notes

This is a collection of my preferences so as to allow quick setup and continuity between machines I use for development

## Steps to bootstrap a new Mac

### Install Apple's Command Line Tools, 
Prerequisites for Git and Homebrew. 

On newer macs this comes out of the box.

```shell
xcode-select --install
```

### Clone repo into the home directory.
[ssh setup](https://github.com/settings/keys)
```shell
git clone git@github.com:aukoyy/dotfiles-zsh.git ~/.
```

### Create symlinks in the Home directory to the real files in the repo.

```shell
# The original .zshrc must be deleted/renamed
ln -s ~/dotfiles-zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles-zsh/.gitconfig ~/.gitconfig
```

### Install Homebrew
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Then pass in the Brewfile if you would like to install these programs.

```shell
brew bundle --file ~/dotfiles-zsh/Brewfile
```

### Set up the terminal

Install oh-my-zsh
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
Install PowerLevel10K
```shell
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
Configure PowerLevel10K
```shell
p10k configure
```

### Configure git
If the .gitconfig file has been symlinked then most of the job is done. If not it can be done like so:
```shell
git config --global user.name "[name]"
git config --global user.email "[email of github account]"
git config --global core.editor "vim" // Sets editor to vim
git config --list // Lists all settings
```

#### Make 'git open' open the repository in the browser
```shell
npm install --global git-open
```
Use by typing git open in a reposetory.

### Adjust dock
Remove animation from dock
```shell
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
```
Remove delay from dock
```shell
defaults write com.apple.dock autohide-delay -float 0; killall Dock
```

Make hidden apps appear as faded in dock
```shell
# Faded
defaults write com.apple.Dock showhidden -bool true; killall Dock
# Revert
defaults write com.apple.Dock showhidden -bool false; killall Dock
```
Insert blank spaces in dock
```shell
defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'; killall Dock
```
Change duration that the screenshot image hangs out. May no longer work due to changes in macOS
```shell
defaults write com.apple.screencaptureui "thumbnailExpiration" -float 15 && killall SystemUIServer
```

## Other mac apps
- TinkerTool
- KeystrokePro

## Future suggestions
- Learn how to use [`defaults`](https://macos-defaults.com/#%F0%9F%99%8B-what-s-a-defaults-command) to record and restore System Preferences and other macOS configurations.
- Automate symlinking and run script files with a bootstrapping tool like [Dotbot](https://github.com/anishathalye/dotbot).
- Find inspiration and examples in other Doffiles repositories at [dotfiles.github.io](https://dotfiles.github.io/).

## Sources
- [Beautiful Terminal Guide](https://medium.com/@shivam1/make-your-terminal-beautiful-and-fast-with-zsh-shell-and-powerlevel10k-6484461c6efb)

- [Beyond Dotfiles in 100 seconds](https://github.com/eieioxyz/Beyond-Dotfiles-in-100-Seconds/blob/master/README.md)

- [git open](https://www.npmjs.com/package/git-open?activeTab=readme)