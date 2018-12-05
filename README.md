# Dotfiles

This repo contains my configuration files for Bash and other CLI tools. It forms part of my larger macOS setup which consists of:

- **dawn**: a script that walks you through the process of setting up a newly-installed copy of macOS from scratch
- **toolbox**: miscellaneous shell scripts that perform various functions (some of questionable utility)
- **dotfiles** (this repo): shell preferences, including useful aliases for common tasks

## How to use

Dotfiles are a great way to customize your shell. Feel free to take a look at the individual files if you want inspiration for your own setup. If you'd like to use my files as a starting point for your own, first clone this repo (I suggest keeping it in your home directory):

```bash
git clone https://github.com/stringlytyped/dotfiles.git ~/dotfiles
```

Then, when you've made your edits, `cd` into the `dotfiles` directory and run:

```bash
./install.sh
```

This will symlink the dotfiles in your home directory.

(If you make changes to the dotfiles later, you can use the `reload` alias to have them take effect.)

## Prerequisites 

## Note about basic Unix commands

Unix operating systems like macOS come installed with a number of standard CLI programs such as `ls`, `mv`, `chmod` and others. The GNU Project maintains a collection of these programs called *coreutils*. While you will find GNU coreutils pre-installed on most Linux distros, Macs instead ship with the BSD versions of these utilities, which are less powerful.

My `bashrc` file assumes that you have GNU coreutils installed on your system and wish to use them in place of the macOS defaults. The `install.sh` script will prompt you to install them if they are missing.

## FAQs

### Will these work on Linux or other Unix systems?

Not without some modification. The `bashrc` file makes use of [Homebrew](https://brew.sh/) (the `brew` command) in order to construct the `PATH` and `MANPATH` environment variables.

### Why don't your dotfiles have dots?

Normally, dotfiles like `.bashrc` are prefixed with a dot (which, of course, is where the name "dotfile" comes from). However, this causes them to be hidden in the Finder. Because I edit these files somewhat regularly, I prefer to keep them visible.

If you'd rather have them hidden from view, rename the `dotfiles` directory to `.dotfiles` and rerun `./install.sh`.

### What's the difference between *.bashrc* and *.bash_profile*?

When the OS starts up a new instance of a shell, it is initialized differently depending on the type of shell. A shell can be interactive or non-interactive and login or non-login (I'll let you Google what the differences are).

Typically we only need our custom configuration to apply to interactive shells (we don't care about non-interactive shells), but we usually want it to apply to both login and non-login shells. To accomplish this, we need put the same config in `.bashrc` (which is loaded for non-login shells) and in `.bash_profile` (which is loaded for login shells). Instead of copying and pasting the code from one file to another, I reference `bashrc` from `bash_profile` using `source`.

(macOS does [a weird thing](https://scriptingosx.com/2017/04/about-bash_profile-and-bashrc-on-macos/) where it loads `.bash_profile` instead of `.bashrc` when you open Terminal.app, even though that should not be treated as a login shell. If we put the same config in both files ultimately it doesn't matter.)

### Why don't the dotfiles start with a hashbang (#!)?

While some of the dotfiles contain Bash code, they aren't shell scripts—they're configuration files. Also, since these files are loaded by Bash when a new shell is started, they will always be executed using the Bash interpreter. Thus, specifying which interpreter to use would be redundant.

### Why don't you use *.aliases*, *.functions* and/or *.path* files?

My `.bashrc` file is quite short at the moment (and I'd like to keep it succinct, if possible), and so breaking it up into different files is probably not necessary at this stage.

### Can I open an issue or submit a pull request?

Sure! If you notice anything broken, you you'd like to see an improvement, please do open an issue. Otherwise, if you'd like to jump in and make some changes yourself, you are welcome to that, but keep in mind I may not always merge all pull requests.

### What is purpose of comments starting with "shellcheck"?

I use a tool called [shellcheck](https://github.com/koalaman/shellcheck) to enforce good practices in my shell scripts. However, every once in a while it will generate a warning that needs to be overwritten. The `shellcheck` comments accomplish this.