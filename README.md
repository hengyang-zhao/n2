# Project N2: The Final Solution of Dot-Files Management in Unix Systems

Project N2 aims solving all the pain points in dot-file management, such as
version control, modularization, etc. It also provides an informative,
customizable `bash`/`tmux` UI by default.

## Install

```
cd $HOME
git clone git@github.com:hengyang-zhao/n2.git .n2
.n2/install
```

The installation tries to be stupid. It just append lines to your existing
dot-files. It does not soft-link, backup, or overwrite your original files for
you, which makes it less obvious when you wish to uninstall it later.

## Features

1. Comes with a manual

Upon installation, you can just do `man n2` to pull up the full reference
manual of project N2.

1. M2 discovery

You must already have some dot-files. Put them into M2 directory(s) and the
version control will be easy.

An M2 directory is a directory under your `$HOME`
and named like `.m2*`. When bash is initializing, N2 will enumerate all the M2
directories and source the configurations under them. A typical M2 directory
looks like this:

```
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
```

1. Customizable bash PS1

1. Informative tmux status bar

