---
title: New Mac Setup
created: '2020-08-08T09:04:34.560Z'
modified: '2021-03-15T08:41:21.488Z'
---

# New Mac Setup

## Guides
* [New mac setup](https://www.youtube.com/watch?v=cIJJ6FaqKVM) - general setup stuff
* [Youtube web dev](https://www.youtube.com/watch?v=tMNOpaQrfAE) - includes homebrew, firefox settings/extensions
* [Multi PHP in osx](https://getgrav.org/blog/macos-catalina-apache-multiple-php-versions) - Explains how to install and switch between multiple php versions in OSX

## General steps
* General
  * Turn off icloud desktop/document syncing - stick to resilio/dropbox
  * Enable finder show path, show status bar
  * Consider using stacks on desktop (groups screenshots etc)
  * Enable accessibility features; ctrl zoom & 3 finger drag (laptop)
  * Download/install apple fonts from [here](https://developer.apple.com/fonts/)
  * You can get general windows fonts once you install Office - see notes below
* Install resilio sync
  * download free version, then generate key link on existing to setup pro license
  * set sync default to disable to allow the folders to be renamed to correct location
* Install dropbox
* Homebrew
  * `xcode-select --install`
  * `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
  * `brew update`
* Homebrew installs  
  * `brew install --cask alacritty` (and/or iterm2)
  * `brew install bash` (installs more recent version than default osx)
    * `sudo vi /etc/shells` and add /usr/local/bin/bash
    * `chsh -s /usr/local/bin/bash`
  * `brew install git`
  * `brew install --HEAD vim`
  * `brew install --HEAD neovim`
  * `brew install --HEAD tmux`
  * `brew tap homebrew/cask-fonts`
  * `brew install --cask font-sauce-code-pro-nerd-font`
* Dotfiles
  * copy in .ssh keys
  * mkdir ~/.dotfiles and cd in
  * `git clone git@github.com:mark-newton/dotfiles.git .`
  * `./install.sh`
  * manually copy in .bash_profile (dotfiles doesn't have this as it usually contains local env)
  * copy in ~/bin/tm script for tmux
* Switch to alacritty/iterm2 now (if Iterm2 then still need to copy in profile)
* Neovim setup (via brew)
  * `brew install node`
  * run the nvim install scripts for coc and fzf (in .config/nvim)
  * copy coc-settings from existing
  * `pip3 install neovim-remote`
  * `npm install -g neovim`
  * run `:checkhealth` in nvim to test (note: python2 & ruby are optional afaik)
* Neovim setup (ALT - chris@mach version)
  * Install Neovim from source
    * `~/bin/install-latest-neovim`
  * Install PIP
    * `sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py`
    * `python3 get-pip.py`
    * `rm get-pip.py`
  * Install Node
    * `brew install lua`
    * `brew install node`
    * `brew install yarn`
    * `npm install -g neovim`
  * Install Pynvim + extras
    * `pip3 install pynvim --user`
    * `brew install ripgrep fzf ranger`
* Other optional homebrew installs 
  * `brew install --cask spectacle`
  * `brew install fortune`
  * `brew install cowsay`
* Firefox
  * `brew install --cask firefox`
  * install lastpass
  * install ublock origin
  * install stylus, then search for stylish GitHub dark to get some styles
  * optional; install tabliss & tampermonkey (js overrides)
* MS Office
  * login to office365 and install from there
  * install fonts from word/show package contents/contents/resource/dfonts
* Copy in Dev folder
* Dev environment
  * OLD INSTRUCTIONS PHP/PHALCON (FOR REF)
    * PHP
      * follow [php guide](https://getgrav.org/blog/macos-catalina-apache-multiple-php-versions). Use switch_php script in ~/bin rather than the one mentioned in the guide
      * on osx catalina you can’t install prior to php7.1 due to incompatibilies with libssl
      * for php7.1 need to install with —build-from-source
      * `brew install composer`
    * Phalcon
      * Note: (as at Aug-2020) phalcon 4.0.6 crashes with php 7.4.8 so you need to also install php 7.4.7 using the last commit point
      * `brew unlink php` (this unlinks only doesn’t delete, so you can switch back to the installed version anytime)
      * `brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/12c36f529f129bd7a404bc8e6692efea1039fe4a/Formula/php.rb` (I got this by searching through the git logs for last 7.4.7 commit)
      * after any brew upgrades that include php, this will force you back onto latest php, so you need to `brew switch php 7.4.7` after the update. Note: this also requires an extra env set in .host to avoid auto cleanup of old versions… export HOMEBREW_NO_INSTALL_CLEANUP=true (this should be in .host if copied from existing)
      * `brew tap phalcon/extension https://github.com/phalcon/homebrew-tap`
      * `brew install phalcon`
  * NEW INSTRUCTIONS PHP/PHALCON
    * PHP
      * follow [php guide](https://getgrav.org/blog/macos-bigsur-apache-multiple-php-versions). Use switch_php script in ~/bin as that works better
      * Note: if you get a weird error about using fully qualified name, try `brew untap exolnet/deprecated`
      * `brew install composer`
    * Phalcon
      * As at Mar-2021 phalcon 4.1 runs fine with php 7.4.16
      * `brew tap phalcon/extension https://github.com/phalcon/homebrew-tap`
      * `brew install phalcon` - this should also auto install php-psr
      * if php-psr doesn't install, uninstall phalcon and try again:
        * `brew list --formula | grep phalcon`
        * `brew ininstall --force phalconxxx`
  * Nginx:
    * `sudo apachectl stop`
    * `sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist`
    * `brew install nginx`
    * `cd /etc/`
    * `sudo ln -s /usr/local/etc/nginx`
    * copy in nginx config from existing
    * `sudo nginx`
    * update /etc/hosts as reqd
  * Mysql (5.7):
    * download/install v5.7 from mysql website (brew installs v8 by standard which creates other issues)
    * update .host (if reqd) with mysql path
    * update global vars to be less restrictive
      * current session; enter mysql then type `set global sql_mode=‘IGNORE_SPACE,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION’;`
      * exec `mysql --help | grep my.cnf` to check available paths for my.cnf (assume /etc/mysql/my.cnf)
      * create /etc/mysql dir then edit my.cnf with sql_mode directive
    * `brew install pv` (for restores)
    * create db’s and users then run script to restore db’s (note: use mysql_native_password plugin)
    * if you get connection issues, check the user was created with plugin mysql_native_password. If not then you can run this in mysql `alter user ‘user’@‘localhost’ identified with mysql_native_password by ‘password’;` 
  * to check nginx/php: `lsof -Pni4 | grep LISTEN | grep ‘php\|nginx’`
