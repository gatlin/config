# Configuration

My desktop configuration at present is semi-automated.

There are two kinds of configuration captured here:

1. dotfiles in `dotfiles/`, and
2. patches / source code mods in `depot/` (see below).

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

[suckless]: https://suckless.org/hacking
