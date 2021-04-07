# set iterm title to pwd
# PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\$ '
export PS1='\[\033[33m\]\w\[\033[37m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    #PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'
    PROMPT_COMMAND='echo -ne "\033]0;`basename ${PWD}`\007"'
    ;;
*)
    ;;
esac

### dont forget to "brew install bash-completion" for this to work
#[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

# to use: 
# setjdk (just sets JAVA_HOME to the default java) 
# setjdk 1.7
# setjdk 1.7.0_51
# also consider using jenv instead
function setjdk() {
  if [ $# -ne 0 ]; then
     removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
     if [ -n "${JAVA_HOME+x}" ]; then
       removeFromPath $JAVA_HOME
     fi
     export JAVA_HOME=`/usr/libexec/java_home -v $@`
     export PATH=$JAVA_HOME/bin:$PATH
  else
     export JAVA_HOME=$(/usr/libexec/java_home)
     ls /Library/Java/JavaVirtualMachines
  fi
}

alias see='open -a TextWrangler '
alias clip.diff='sdiff -s <(pbpaste)'
alias clip.diff.ls='sdiff -s <(pbpaste) <(ls)'
alias beep='say "beep. there, i said it. happy now?"'
alias pwd.pbcopy="pwd -P | tr -d '\n' | pbcopy"
### note for this to work in Beyond Compare, in BC click Rules toolbar button (referee icon) > Handling tab > Follow symbolic links
alias git.diff.visual='git difftool -d'
alias git.merge.visual='git mergetool'

git config --global diff.tool bc3
git config --global merge.tool bc3
git config --global mergetool.bc3.trustExitCode true

alias diff.visual='bcomp'
alias vdiff='bcomp'
#
# not needed, instead open Beyond Compare and choose Install Command Line Tools...
# which installs /usr/local/bin/bcomp
#function bcomp() {
#    local bcomptool='/Applications/Beyond Compare.app/Contents/MacOS/bcomp'
#    "$bcomptool" $@
#}

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

