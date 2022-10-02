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