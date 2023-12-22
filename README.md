# dotfiles
This is my dotfile playground for learning nix as my reproducable setup for handling dotfiles on a macOS system

this will be a translation of my dotfiles.fish setup

this repository will be updated & improved upon as I learn the nix language and ways of working


## Installation
### nixOS:

Taken directly from nxiOS.org:
```shell
 sh <(curl -L https://nixos.org/nix/install)
````
### Homebrew:
read more: https://brew.sh/
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Home manager
read more: https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone

```shell
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```


