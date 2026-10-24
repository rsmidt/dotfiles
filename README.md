# dotfiles

Config for balmorra (desktop), ilum (laptop) and a work Mac, deployed with
[mise dotfiles](https://mise.jdx.dev/dotfiles.html).

## Layout

- `mise.toml`: all machines (zsh, nvim, vim, git, starship, kitty)
- `mise.private.toml`: balmorra and ilum (niri, DMS, ssh, packages)
- `mise.<host>.toml`: one machine, from `hosts/<host>/`

A machine picks its layers in `~/.config/mise/miserc.local.toml`:

```toml
env = ["private", "ilum"]
```

Per-machine config that isn't tracked: `~/.config/zsh/local.d/`,
`~/.config/nvim/lua/local.lua`, `~/.gitconfig`, `~/.ssh/config` and
`~/.config/mise/config.toml`.

## Setup

```sh
git clone https://github.com/rsmidt/dotfiles.git ~/dotfiles
cd ~/dotfiles && mise trust
mise bootstrap
```

Existing files aren't overwritten, so move them out of the way first.

## Secrets

`secrets/` is encrypted with sops to the age key in `.sops.yaml`, which only
balmorra and ilum have.

```sh
sops edit --input-type binary --output-type binary secrets/ssh-servers.json
```

`.githooks/pre-commit` runs gitleaks and rejects unencrypted files in
`secrets/` as well as commits from other identities.
