dotfiles
========

My personal config files

Much was taken nearly verbatim from github.com/jaburns and http://code.tutsplus.com/tutorials/setting-up-a-mac-dev-machine-from-zero-to-hero-with-dotfiles--net-35449

##Instructions

###Install Homebrew

```bash
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install caskroom/cask/brew-cask
$ brew cask install google-chrome
$ brew cask install dropbox
```
etc

### Clone dotfiles repo

```bash
$ sudo git clone https://github.com/leepavelich/dotfiles.git && cd dotfiles && source bootstrap.sh
```

### Source

```bash
$ source bootstrap.sh
$ source .osx
```
