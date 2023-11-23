# Thiago's Dotfiles

Dotfiles are the personalization files for your Linux or Unix-based system. You can identify them by the file names starting with a period, which makes them hidden from plain view. This repository contains my own dotfiles, and they're here for convenience. I keep them handy for setting up new machines or fresh installs. Feel free to explore – you might find some useful ideas for customizing your own dotfiles!

## Usage

### Windows Host with WSL

If you are using Windows as a host and want to configure a developement environment inside WSL, follow the instruction on the [.winhost/README.md](.winhost/README.md) file. In this README you'll find a specific bootstrap script for configuring Windows + WSL. That script will configure many things inside the Windows host and inside WSL as well. If you are curious about how it works, take a peek and change however you like.

### Linux or MacOs Host

> 🚨 Folow this steps only if you are using a Linux system as a host (or if you want to setup just the Linux env).

1. Install yadm with `sudo apt install yadm -y`
2. Clone the repository `yadm clone --bootstrap git@github.com:thiagomajesk/dotfiles.git`

> In case of problems, make sure the bootstrap script is executable!  
> You can run `chmod +x ~/.config/yadm/bootstrap.sh` and then try again with `yadm bootstrap`.

## Managing dotfiles

The dotfiles are managed using YADM for files inside WSL and a series of template files for the Windows Host. YADM it's based off of git, and it shares many common commands with it. You can read more about YADM in its [official documentation](https://yadm.io/), but here's the gist of it:

- `yadm status` to show changed files
- `yadm add` to track changes to a file
- `yadm commit` to commit changes to the repository
- `yadm push` to push changes to the repository
- `yadm pull` pull the latest changes from the repository

## Tooling

### Helix and [Neo]Vim

#### Clipboard sharing

To enable clipboard sharing on Windows while using WSL, you must install a package called `win32yank`.  
This package should be included by default in the `scoopfile.json`, but you can install it manually by running `scoop install win32yank`.
