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

# ctrl+n: pick a file with fzf and open it in nvim
function fzf_nvim
    set -l file (fd --type f --hidden --exclude .git | fzf --height 40% --reverse)
    if test -n "$file"
        nvim $file
    end
    commandline -f repaint
end
bind \cn fzf_nvim
bind -M insert \cn fzf_nvim
