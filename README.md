# Project N<sub>2</sub>

_The final solution of dot-file management for Unix systems_

Project N<sub>2</sub> aims to solve all the pain points in general dot-file management,
such as version control, modularization, etc. It also provides an informative
and customizable `bash`/`tmux` UI.

## Install

    cd "$HOME"
    git clone git@github.com:hengyang-zhao/n2.git .n2
    .n2/install.sh

The installation tries to be stupid. It just appends lines to your existing
dot-files. It does not soft-link, backup, or overwrite your original files for
you, which makes it less obvious in case you wish to uninstall it later.

You can also install N<sub>2</sub> to a playground outside of your `HOME`:

    PLAYGROUND=yes .n2/install.sh

or (to save some confirmation typings)

    AUTO_CONFIRM=yes PLAYGROUND=yes .n2/install.sh

> **Note** <br/>
> `AUTO_CONFIRM=yes` works in the regular (non-playground) mode too.

> **Note** <br/>
> The cloned directory can be named and placed arbitrarily. It doesn't
> have to be named `.n2` or placed directly under your `HOME`. But for M<sub>2</sub>
> directories (optional feature, mentioned below), they have to follow the
> predefined pattern.

## Features

### Comes with a manual

After installation, you can just do `man n2` to pull up the N<sub>2</sub> reference
manual.

### M<sub>2</sub> discovery

You must already have some configs in your dot-files. Move them into M<sub>2</sub>
directory(s) such that they can be easily verson-controlled.

> **Note** <br/>
> You still have the freedom to keep your configs in their
> original places, i.e., `~/.bashrc`, `~/.vimrc`, etc. You can skip this section
> if you wish to do so.

An M<sub>2</sub> directory is a directory under your `HOME` and named like `.m2*`. When
bash is initializing, N<sub>2</sub> will enumerate all the M<sub>2</sub> directories and source the
configurations under them. A typical M<sub>2</sub> directory looks like this:

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

Then you know where to put your old configs.

If you don't like creating an M<sub>2</sub> directory from scratch, N<sub>2</sub> can automatically
create one:

    n2 create-m2

The demo M<sub>2</sub> dir is a good start point. It already has several files to help you
customize N<sub>2</sub> and add personal configs.

> **Tip** <br/>
> Version-controlling your M<sub>2</sub> dir is often a good idea.

You also have the freedom to have multiple M<sub>2</sub> directories. This becomes useful
when you want to separate your M<sub>2</sub> dirs for personal use and work. If this is
the case, a typical home directory will look like this:

    ~
    ├── .n2
    ├── .m2-10-personal
    ├── .m2-20-work
    └── MyOtherStuff

> **Note** <br/>
> The M<sub>2</sub> directories are discovered in lexical order. Those odd-looking
infixes `-10-` and `-20-` are just to control that order.

For more details, see `man n2`.

### Customizable bash PS1

By default, N<sub>2</sub> has a rich bash [PS1](https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html#Controlling-the-Prompt)
prompt. In addition to a colorful `user@host` and current working directory, it
also has

- a git repo/branch indicator;
- the permission bits of the current directory if it's not readable or writable;
- the nesting level of the current bash, if it's not the outermost one;
- number of processes running in the background;
- the physical cwd, if the appearing cwd is a symlink;

and some less frequent ones

- the nice value of current bash if it's not 0;
- a chroot indicator honoring `debian_chroot`;
- the session name if in a GNU screen session;
- `IFS` value if not default (`\x20\x09\x0a`).

To checkout the current prompt:

    echo "$PS1"

To customize this, just overwrite `PS1` in your M<sub>2</sub> configs.

### Informative tmux status bar

The status bar shows

- hostname and session name;
- the current TTY path if the session is multi-attached;
- window list;
- system load / number of cores;
- date and time.

### Command expansion

Command expansion is the lines starting with `[#] -> XXX`, for example

    me@laptop ~
    $ ls
    [1] -> /opt/homebrew/opt/coreutils/libexec/gnubin/ls --color=auto (MM/DD/YYYY HH:MM:SS)
    -- OUTPUT SKIPPED --

or

    me@laptop &1 ~
    $ grep pattern < file | wc
    [1] -> /usr/bin/grep --color=auto pattern < file (MM/DD/YYYY HH:MM:SS)
    [2] -> /opt/homebrew/opt/coreutils/libexec/gnubin/wc (MM/DD/YYYY HH:MM:SS)
    -- OUTPUT SKIPPED --

or

    me@laptop ~
    $ echo hello && echo world
    [1] -> builtin echo hello (MM/DD/YYYY HH:MM:SS)
    hello
    [2] -> builtin echo world (MM/DD/YYYY HH:MM:SS)
    world

Features include

- telling if the command was an external command (by expanding its true path),
  or if it's a shell builtin;
- timestamping the commands right before the command is executed;
- breaking up commands by pipe operators and logical operators;
- making sure that once a expansion is printed out, the command is starting to
  execute --- this is especially useful when you copy-paste a command with a
  trailing line-break character into bash, but you just don't know if it's
  already executing or waiting for `ENTER`.

### Better status reporting

Automatically prints the status code and timestamp after a user input is
completed. If it's a piped command, it prints out status code of each pipelet.
The timestamp is often used together with the ones in command expansion to
figure out how long a command was running for.

