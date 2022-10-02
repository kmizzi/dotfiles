function debugsku {
        tmux new -d -s tmaster "tmux splitw -vf;tmux send -t 0 'sku' Enter 'll' Enter;tmux send -t 1 'sku' Enter;zsh"
        tmux a -t tmaster
}
alias sku="sudo su - sku"