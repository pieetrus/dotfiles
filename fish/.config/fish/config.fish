source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting to disable fastfetch
function fish_greeting
end
export PATH="$HOME/.local/bin:$PATH"

zoxide init --cmd cd fish | source

alias lg='lazygit'
alias cc='claude --model sonnet --dangerously-skip-permissions'
alias vim='nvim'
alias n='nvim'
