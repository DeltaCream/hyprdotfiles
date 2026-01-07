# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# pnpm
export PNPM_HOME="/home/cream/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Add cargo for Rust
. "$HOME/.cargo/env"

# Add deno
. "/home/cream/.deno/env"

# Add deno bash completions
source /home/cream/.local/share/bash-completion/completions/deno.bash

# Add awww bash completions
source /home/cream/.local/share/bash-completion/completions/awww.bash

export GOPATH="/home/cream/go"
export GOBIN="/home/cream/go/bin"
export PATH="$PATH:$HOME/go/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(starship init bash)"
fastfetch
