## this script only needs to be run once, does NOT need to be sourced into .bashrc or .bash_profile

BASH_MINIMAL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P)"

#mkdir -p $HOME/.vim-tmp/{swap,undo,backup}
#mkdir -p $HOME/.vim/plugin
#ln -s $BASH_MINIMAL_DIR/.vimrc $HOME/.vimrc
#ln -s $BASH_MINIMAL_DIR/.vim/plugin/bash-minimal.vim $HOME/.vim/plugin/
ln -s $BASH_MINIMAL_DIR/.vim/plugin/easytabs.vim $HOME/.vim/plugin/
