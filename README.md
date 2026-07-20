# Linux Dotfiles – Stow Repository

This repository contains a **stow‑compatible** layout of my configuration files that were originally stored in a Windows `$HOME` folder. All Windows‑only artefacts (PowerShell scripts, `.ps1` files, `Windhawk` JSONs, etc.) have been omitted.

## Repository layout
```
 dotfiles-linux/
 ├─ README.md                 # ← you are reading this
 ├─ bash/                     # Bash shell configuration
 │   └─ .bashrc               # $HOME/.bashrc
 ├─ git/                      # Git configuration
 │   └─ .gitconfig            # $HOME/.gitconfig
 ├─ nvim/                     # Neovim configuration
 │   └─ .config/
 │       └─ nvim/            # $HOME/.config/nvim/*
 ├─ tmux/                     # tmux configuration
 │   └─ .config/tmux/tmux.conf
 ├─ fastfetch/                # fastfetch config
 │   └─ .config/fastfetch/config.jsonc
 ├─ wezterm/                  # WezTerm terminal configuration
 │   └─ .config/wezterm/*
 ├─ yazi/                     # Yazi file‑manager configuration
 │   └─ .config/yazi/*
 ├─ lazygit/                  # Lazygit UI config
 │   └─ .config/lazygit/config.yml
 ├─ scripts/                  # Helper scripts (fzf integration, ssh manager)
 │   ├─ fzf/                  # $HOME/fzf/* – fzf preview/open helpers
 │   └─ ssh-manager.sh        # $HOME/ssh-manager.sh
 ├─ whkd/                     # whkdrc – placeholder for a Linux hot‑key daemon
 │   └─ .config/whkdrc
 ├─ yasb/                     # yasb status bar config
 │   └─ .config/yasb/*
 └─ glaze-wm/                 # glaze‑wm window manager config (optional)
     └─ .config/glaze-wm/config.yaml
```

## Installing with **stow**
```bash
# Clone the repo somewhere, e.g. $HOME/.dotfiles
git clone https://github.com/your‑name/dotfiles-linux.git $HOME/.dotfiles
cd $HOME/.dotfiles

# Install a package (run for each you want):
stow -t $HOME bash
stow -t $HOME git
stow -t $HOME nvim
stow -t $HOME tmux
stow -t $HOME fastfetch
stow -t $HOME wezterm
stow -t $HOME yazi
stow -t $HOME lazygit
stow -t $HOME scripts
stow -t $HOME whkd
stow -t $HOME yasb
stow -t $HOME glaze-wm   # optional
```

Each `stow` command creates symlinks inside `$HOME` that point to the files under the package. Most packages nest their files under a `.config` directory (mirroring `$HOME/.config/...`), while `bash`, `git`, and `scripts` place their files directly in `$HOME`.

## Adapting Windows‑specific shortcuts
The original `whkdrc` file contained Windows‑only commands (PowerShell, `taskkill`, `komorebic`, etc.). The version provided here is a **Linux template** – replace the sample bindings with ones that work for your window manager (i3, sway, hyprland, etc.). The same applies to `glaze-wm` and `yasb`, which originate from a Windows setup.

## License
Feel free to fork, edit, and use these dotfiles under the same license as the original repository.
