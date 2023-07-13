# bdwalton@'s Environment Config

This package carries all of my default configuration preferences for
my Linux environment and knows how to activate the various settings I
rely on.

To use it, clone the repository and run:

```
./setup-env
```

If this is the first use, that invocation will fail. Instead, try:

```
./setup-env home
```

Where `home` is the name of the environment you're setting up. This
will create a `~/.bdwconfig` file with an appropriately exported
environment variable named `BDW_CONFIG_TYPE` which is leveraged by
many of the other configurations in this repository.

Subsequently, you can run:

```
./update-config && ./setup-env
```

This will download the latest configs and then refresh the
environment.


## BDW_CONFIG_TYPE

The `BDW_CONFIG_TYPE` variable is referenced by many dotfiles to
conditionally import more configuration if there are
environment-specific things that are required. For example, you might
prefer a different git config user.email value in different
environments, so the `.gitconfig` dotfile is setup to import
`.gitconfig-${BDW_CONFIG_TYPE}` which can override settings.

## Shadow Environments

In some cases, rather than carrying all config for an environment in a
single repository, it may be required to maintain a secondary
repository. The `setup-env` tools know how to handle that for special
cases and will expect to clone and run `setup-env` from these parallel
repositories as required.

## Dotfiles

We're managing dotfiles using
[Dotbot](https://github.com/anishathalye/dotbot), from the `dotfiles`
directory of this repository. To track a new dotfile, create it in the
`dotfiles` directory and reference it from
`dotfiles/install.conf.yaml`.

## Systemd Service Units

We manage a few things via systemd user service units. Place valid
.service files in systemd-user and they will be delivered and
installed.

## Expected Packages

To track new Debian packages that are expected, simply add the package
name to `debian_packages`. Similarly, for PIPx (python) packages, add
the package name to `pipx_packages`. This file takes a package name
and an optional comma separated list of dependencies to add to the
saem venv on the package. `npm_packages` is a list of npm javascript
packages we like to have. Lastly, `golang_packages` is a list of URLs
suitable for use by `go install`. They will be installed using `good`
so they're isolated from your main GOPATH. After updating any of these
files, you can re-run `setup-env` to have the packages added
appropriately.

## DConf Settings

We use sway, but rely on bits and pieces of a gnome environment for some
conveniences. As such, we configure various dconf knobs that gnome/gtk apps rely
on. This is done by adding lines to `dconf_settings` where each line is a key
(first item) and a value (everything else). These are setup by one of the
scripts described below.

## Fonts

Font files in the `fonts` directory will be installed in ~/.fonts/.

## Miscellaneous Scripts

To do miscellaneous setup to configure the environment, you can add
scripts in the `scripts` directory. These are run in lexical order, so
you can ensure certain things are run early or late by managing the
numeric sequence of the script names.
