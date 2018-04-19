case "$TERM" in
    xterm) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

black="\[\033[0;30m\]"
blackBold="\[\033[1;30m\]"
blackUnderl="\[\033[4;30m\]"
red="\[\033[0;31m\]"
redBold="\[\033[1;31m\]"
redUnderl="\[\033[4;31m\]"
green="\[\033[0;32m\]"
greenBold="\[\033[1;32m\]"
greenUnderl="\[\033[4;32m\]"
yellow="\[\033[0;33m\]"
yellowLight="\[\033[1;33m\]"
yellowUnderl="\[\033[4;33m\]"
blue="\[\033[0;34m\]"
blueBold="\[\033[1;34m\]"
blueUnderl="\[\033[4;34m\]"
purple="\[\033[0;35m\]"
purpleBold="\[\033[1;35m\]"
purpleUnderl="\[\033[4;35m\]"
cyan="\[\033[0;36m\]"
cyanBold="\[\033[1;36m\]"
cyanUnderl="\[\033[4;36m\]"
white="\[\033[0;37m\]"
whiteBold="\[\033[1;37m\]"
whiteUnderl="\[\033[4;37m\]"

if [ "$color_prompt" = yes ]; then    
    # export PS1="$white[\$(date +'%Y-%m-%d %H:%M:%S')] $red\u$blue@\h$white:$green\W \$$white "
    # export PS1="${debian_chroot:+($debian_chroot)}$red\u$blue@\h$blue:$green\w$green\$$white "
    # export PS1="${debian_chroot:+($debian_chroot)}$red\u$blueBold@\h$blue:$green\W$green\$$white "
    # export PS1="${debian_chroot:+($debian_chroot)}$cyan\u$cyan@\h$cyan:$yellow\W$yellow \$$white "
    export PS1="${debian_chroot:+($debian_chroot)}$cyan\u$yellow:\W$blueBold\$(parse_git_branch)$white \$ "
else
    export PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
fi

alias open='xdg-open'
