#!/bin/bash
REPO_NAME=ryukinix/dotfiles
IGNORED_FILES=(README.md # these files will be removed
               setup.sh
               lib.sh
               conf.sh
               install.sh
               post-hook)
BACKUP_DIR=.dot-backup/$(date -Iseconds)
PACKAGES=(zsh vim emacs tmux)
XPACKAGES=(rofi conky)
DEFAULT_SHELL=zsh

# if there is xinit installed install more things
if command -v xinit > /dev/null; then
    PACKAGES+=( "${XPACKAGES[@]}" )
fi
