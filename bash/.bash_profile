# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
. "/home/cream/.deno/env"
source /home/cream/.local/share/bash-completion/completions/deno.bash
. "$HOME/.cargo/env"
