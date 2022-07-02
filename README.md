# Project N2

**N2: The Final Solution of Dot-Files Management for Unix Systems**

Project N2 aims to solving all the pain points in dot-file management, such as
version control, modularization, etc. It also provides an informative and
customizable `bash`/`tmux` UI by default.

## Install

    cd $HOME
    git clone git@github.com:hengyang-zhao/n2.git .n2
    .n2/install.sh

The installation tries to be stupid. It just append lines to your existing
dot-files. It does not soft-link, backup, or overwrite your original files for
you, which makes it less obvious when you wish to uninstall it later.

## Features

### Comes with a manual

Upon installation, you can just do `man n2` to pull up the full reference
manual of project N2.

### M2 discovery

You must already have some dot-files. Put them into M2 directory(s) and the
version control will be easy.

An M2 directory is a directory under your `$HOME` and named like `.m2*`. When
bash is initializing, N2 will enumerate all the M2 directories and source the
configurations under them. A typical M2 directory looks like this:

    ~/.m2
    ├── bash
    │   ├── profile.d
    │   │   ├── 10-my-profile.sh
    │   │   ├── 20-another-profile.sh
    │   │   └── not-starting-with-number-is-ok.sh
    │   └── rc.d
    │       ├── 10-my-rc.sh
    │       ├── 50-another-rc.sh
    │       └── not-starting-with-number-is-ok.sh
    ├── exec
    │   ├── my-exec
    │   └── another-exec
    ├── git
    │   └── config
    ├── tmux
    │   └── conf
    └── vim
        ├── 10-my-config.vim
        ├── 20-another-config.vim
        └── not-starting-with-number-is-ok.vim

Then you know where to put your old dot-files. Just follow the same structure.

You also have the freedom to have multiple M2 directories. This becomes useful
when you want to separate your M2 dirs for personal use and work. If this is the
case, a typical home directory will look like this:

    ~
    ├── .n2
    ├── .m2-10-personal
    ├── .m2-20-work
    └── MyOtherStuff

Note that the M2 directories are discovered in lexical order. Those wierd
looking infixes `-10-` and `-20-` are just to control that order.

For more details, see `man n2`.

### Customizable bash PS1

TBA

### Informative tmux status bar

TBA

### Command expansion

TBA

### Better status reporting

TBA

### Labs

TBA

### Toy box

TBA

