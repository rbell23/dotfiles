if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

if status is-login
    cd ~/git
end

zoxide init fish | source
fzf --fish | source

set -U fish_greeting

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
source $HOME/.tenv.completion.fish

# Created by `pipx` on 2025-04-16 14:12:49
set PATH $PATH /Users/robert.bell/.local/bin
