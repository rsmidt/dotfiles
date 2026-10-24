# dotfiles

Managed with [mise dotfiles](https://mise.jdx.dev/dotfiles.html): files in
`home/` and `hosts/` are symlinked (or rendered) into place by `mise dot apply`.

## Layers

| File                 | Applies to                    | What's in it                                    |
| -------------------- | ----------------------------- | ----------------------------------------------- |
| `mise.toml`          | every machine (incl. work Mac) | zsh, nvim, vim, git, starship, kitty, global tools |
| `mise.private.toml`  | balmorra + ilum               | niri, ssh hosts, immich, zypper packages        |
| `mise.balmorra.toml` | balmorra                      | `hosts/balmorra/*`                              |
| `mise.ilum.toml`     | ilum                          | `hosts/ilum/*`                                  |

Each machine picks its layers in `~/.config/mise/miserc.local.toml` (never
committed):

```toml
env = ["private", "ilum"]   # ilum
env = ["private", "balmorra"] # balmorra
# work Mac: no file needed
```

## Machine-local overrides (never tracked)

| What  | Where                                                         |
| ----- | ------------------------------------------------------------- |
| zsh   | `~/.config/zsh/local.d/*.zsh`                                 |
| nvim  | `~/.config/nvim/lua/local.lua` (gitignored)                   |
| git   | `~/.gitconfig` (includes the shared config; `git config --global` writes here) |
| ssh   | `~/.ssh/config` (gets an `Include ~/.ssh/config.d/*` line)    |
| mise  | `~/.config/mise/config.toml` and `config.local.toml`          |
| kitty | `~/.config/kitty/host.conf` when the host layer doesn't set it |

## Secrets

`secrets/` holds [sops](https://github.com/getsops/sops) files encrypted to the
age key in `~/.config/sops/age/keys.txt`, which only balmorra and ilum have.
Templates decrypt them at apply time, so `sops` must be installed.

```sh
sops edit secrets/immich-auth.yaml
sops edit --input-type binary --output-type binary secrets/ssh-servers.json
```

SSH private keys are per machine and not in this repo. Every machine uses the
same file names (`~/.ssh/<target>_ed25519`), so the shared config works
everywhere.

## Setting up a machine

```sh
git clone git@github.com:rsmidt/dotfiles.git ~/dotfiles
echo 'env = ["private", "ilum"]' > ~/.config/mise/miserc.local.toml
cd ~/dotfiles && mise trust
mise dot apply --dry-run
mise bootstrap   # repos (oh-my-zsh + plugins), packages, dotfiles, tools
```

`mise dot apply` refuses to overwrite existing files; move them aside (or pass
`--force` once you've checked them) on the first run.
