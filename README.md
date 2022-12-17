---
title: Configuraiton
...

# Configuration

My desktop configuration at present is semi-automated.

There are two kinds of configuration captured here:

1. dotfiles in `dotfiles/`, and
2. `depot/` for a number of applications which are distributed in source form
and configured by modifying it.

## Prerequisites

- GNU stow

## Dotfiles

For each package `$PKG` in `dotfiles/` you install it by running:

```console
> stow -t $HOME $PKG
```

## Depot

Some applications such as `dwm`, `st`, `slock`, and others are distributed as
source code with the intention that the end-user will build the package
themself, configuring and customizing them by editing the source code.

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

