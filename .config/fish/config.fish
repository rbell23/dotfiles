# pipx and Hermes install user-local executables here.
fish_add_path "$HOME/.local/bin"

# Prompt, navigation, and completions are only needed by interactive shells.
# Guard optional workstation tools so this config also works in machine images.
if status is-interactive
    set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
    set -g fish_greeting

    type -q starship; and starship init fish | source
    type -q zoxide; and zoxide init fish | source
    type -q fzf; and fzf --fish | source

    if status is-login; and test -d "$HOME/git"
        cd "$HOME/git"
    end

    test -r "$HOME/.orbstack/shell/init2.fish"; and source "$HOME/.orbstack/shell/init2.fish"
    test -r "$HOME/.tenv.completion.fish"; and source "$HOME/.tenv.completion.fish"
end
