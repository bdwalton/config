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

## Expected Packages

To track new Debian packages that are expected, simply add the package
name to `debian_packages` and re-run `setup-env`. Similarly, for PIP
(python) package, add the package name to `pip_packages` and re-run
`setup-env`.

## Miscellaneous Scripts

To do miscellaneous setup to configure the environment, you can add
scripts in the `scripts` directory. These are run in lexical order, so
you can ensure certain things are run early or late by managing the
numeric sequence of the script names.
