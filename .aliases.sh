alias emacs='emacsclient -nw -a vim'
alias semacs='SUDO_EDITOR="emacsclient -t -a vim" sudoedit'
alias svim='SUDO_EDITOR=vim sudoedit'
alias remacs='sudo rc-service emacs.lerax restart'
alias agenda='gcalcli agenda'
alias dotnet-build='msbuild'
alias sbcl='rlwrap sbcl'
alias lisp=sbcl
alias lain=lein
alias dic=sdcv



# don't use nosetests anymore, is legacy broken and fucked
alias nosetests='nose2'

alias deadstar-bind-up='ssh -Y lerax@deadstar -t "x2x -north -to :0.0"'
alias deadstar-bind-left='ssh -Y lerax@deadstar -t "x2x -west -to :0.0"'
alias deadstar-bind-right='ssh -Y lerax@deadstar -t "x2x -east -to :0.0"'
alias deadstar-bind-down='ssh -Y lerax@deadstar -t "x2x -south -to :0.0"'
alias starfox='ssh lerax@starfox'
alias deadstar='ssh lerax@deadstar'
alias ustar='ssh server.lerax.me'
alias lerax.me='ssh server.lerax.me'
# save definition of dot (graphviz language)
alias dot-graph='/bin/dot'
function dot {
    GIT_DIR=$HOME/.dot GIT_WORK_TREE=$HOME git $@
}
alias dot-tig='GIT_DIR=$HOME/.dot/ tig'


# xclipboard
alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -o -selection clipboard'

alias ufc='cd ~/Dropbox/University/Courses/UFC/2017.2/'


function ixx {
    link=`ix "${@:1}" 2> /dev/null`
    if [ $? -eq '0' ]; then
        echo $link | xclip -selection clipboard
        printf "Copied '%s' to X clipboard.\n" $link
    fi
}

# you need tmate to use that
alias ssh-share='tmux detach -E "tmate && zsh"'

# mouse driver
alias mouse-driver="ratslap"

# making docker life more easy
alias dc=docker
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias sprungex='sprunge | xcopy'
alias pastebin=sprungex

alias tmate="tmux detach-client -E 'tmate;tmux'"
