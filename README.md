# Configuration

My desktop configuration at present is semi-automated.

There are three kinds of configuration captured here:

1. dotfiles in `dotfiles/`,
2. patches / source code mods in `depot/` (see below), and
3. custom scripts I have written over time.

## Prerequisites

For package management and source code management:

- GNU `stow`
- `git`

Utilities assumed by various scripts and configs:

- `fzf`
- `rg`
- `urlscan`
- `w3m` and its `w3mimg` image loading extensions
- `newsboat`
- awk / grep / the usual gang

# Dotfiles

For each package `$PKG` in `dotfiles/` you install it by running:

```console
> stow -t $HOME $PKG
```

## Exception: Firefox

The Firefox custom stylesheet is tricky to place automatically since once of
its enclosing directories is a "profile ID" which may change.
It will simply need to be placed in
`$HOME/.mozilla/firefox/[PROFILEID]/chrome`.

# Depot

Some applications such as `dwm`, `st`, `slock`, and others are distributed as
source code with the intention that the end-user will build the package
manually.
The intended way to customize or extend them is to edit the code and apply
patches.
[(Information about this way of doing things.)][suckless]
Fortunately they almost all follow the same conventions.

Each `$PKG` in `depot/` corresponds to source code checked out at
`$HOME/code/$PKG`.
To install a given `$PKG`,

```console
> stow -t $HOME/code/$PKG $PKG
> cd $HOME/code/$PKG
> # ... apply any patches ...
> make
> make PREFIX=/home/gcj/.local install # see note below
```

**Note**: different packages may require marginally different arguments to
`make` so see their specific README first.

# Scripts

I have written helper scripts to assist with wifi and bluetooth connections,
generate passwords, and generate ｆｕｌｌｗｉｄｔｈ ｔｅｘｔ (among other
concerns).
Since `.local/bin` is in my shell PATH all of my scripts are installed there
with one command:

```console
> stow -t $HOME scripts
```

[suckless]: https://suckless.org/hacking
