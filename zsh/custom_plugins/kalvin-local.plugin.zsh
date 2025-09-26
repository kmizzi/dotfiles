alias sku="cd ~/code/sku.io/"
alias master="ssh skumaster"
alias dev="ssh cricket"
alias mayfly="ssh mayfly"
alias staging="ssh sku"
alias helper="cd ~/code/helper"
alias localdev="~/localdev.sh"

function localdev {
	tmux new -d -s tmaster "tmux splitw -vf;tmux splitw -h -p 66;tmux splitw -h -p 50;tmux send -t 0 'sku' Enter 'll' Enter;tmux send -t 1 'cd ~/code/sku.io/frontend;yarn run serve' Enter;tmux send -t 2 'cd ~/code/sku.io;php artisan serve' Enter;tmux send -t 3 'cd ~/code/sku.io;php artisan horizon' Enter;zsh"
	tmux a -t tmaster
}

function localdev2 {
	tmux a -t tmaster || tmux new -s tmaster "tmux splitw -vf;tmux splitw -h -p 66;tmux splitw -h -p 50;tmux send -t 0 'sku' Enter 'll' Enter;tmux send -t 1 'cd ~/code/sku.io/frontend;yarn run serve' Enter;tmux send -t 2 'cd ~/code/sku.io;php artisan serve' Enter;tmux send -t 3 'cd ~/code/sku.io;php artisan horizon' Enter;zsh"
}

function start {
	sudo service ssh start
	sudo mongod --bind_ip_all --fork --logpath /var/log/mongod.log
	sudo redis-server --daemonize yes
	sudo service mysql start
	sudo service apache2 restart
}

function stop {
	sudo killall mongod
	sudo killall redis-server
	sudo service mysql stop
	sudo service apache2 stop
}

function startsku {
	start
	cd ~/code/sku.io/frontend
	yarn run serve
	php artisan serve
	php artisan horizon
}

tmx() {
  if [ -z "$TMUX" ]; then
    echo "Active sessions: "
    echo ""
    tmux ls
    echo ""

    read inputTmuxSessionName"?tmux session name: (default | skip - to omit tmux initialization) "

    if [ $inputTmuxSessionName ! "" ]; then
      tmuxSessionName="default"
    else
      tmuxSessionName=$inputTmuxSessionName

      if [ $inputTmuxSessionName = "skip" ]; then
        echo "Skipping"
        return
      fi
    fi

    echo "Attaching to $tmuxSessionName"

    tmux attach -t $tmuxSessionName || tmux new -s $tmuxSessionName
  fi
}

cd ~/


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/mariadb@10.5/bin:$PATH"

# Machine-specific configuration moved from zshrc

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/kalvin/Library/Application Support/Herd/config/php/83/"

# Herd injected PHP binary.
export PATH="/Users/kalvin/Library/Application Support/Herd/bin/":$PATH
#export PATH="/opt/homebrew/opt/mariadb@10.11/bin:$PATH"
export NODE_OPTIONS=--openssl-legacy-provider

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kalvin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kalvin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kalvin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kalvin/google-cloud-sdk/completion.zsh.inc'; fi

#export PKG_CONFIG_PATH=$(brew --prefix openssl@3)/lib/pkgconfig
#export OPENSSL_ROOT_DIR=$(brew --prefix openssl@3)
#export PATH=$(brew --prefix curl)/bin:$PATH

export PATH="$PWD/vendor/bin:$PATH"
export PATH="$PATH:$(pwd)"
export PATH="$HOME/bin:$PATH"
alias skudock='/Users/kalvin/code/sku.io/skudock'
alias odocs='cd "/Users/kalvin/Library/Mobile Documents/iCloud~md~obsidian/Documents/Kalvin"'
alias cdocs='cd "/Users/kalvin/Library/Mobile Documents/iCloud~md~obsidian/Documents/Kalvin" && claude'
source ~/.zshrc_tsv_helper

#. "$HOME/.atuin/bin/env"

#eval "$(atuin init zsh)"
