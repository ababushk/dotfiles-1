# when run inside emacs make this special
if [ -v INSIDE_EMACS ]; then
    export GIT_EDITOR=emacsclient
fi

# need do that on tramp (not working yet)
# FIXME: why tramp doesn't works with zsh as default shell?
if [[ "$TERM" == "dumb" && -v INSIDE_EMACS ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    #unfunction precmd
    #unfunction preexec
    PS1='$ '
fi

if [[ $TERM == "xterm" ]]; then
    export TERM=xterm-256color
fi
