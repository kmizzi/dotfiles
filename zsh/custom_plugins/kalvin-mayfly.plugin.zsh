function debugcurvy {
        tmux new -d -s tmaster "tmux splitw -vf;tmux send -t 0 'sku' Enter 'curvy' Enter 'll' Enter;tmux send -t 1 'sku' Enter 'curvy' Enter;zsh"
        tmux a -t tmaster
}

function debugcp {
        tmux new -d -s tmaster "tmux splitw -vf;tmux send -t 0 'sku' Enter 'cp' Enter 'll' Enter;tmux send -t 1 'sku' Enter 'cp' Enter;zsh"
        tmux a -t tmaster
}

alias cp="cd /var/www/coffeeparts.sku.io/current"
alias curvy="cd /var/www/curvy.sku.io/current"
alias sku="sudo su - sku"