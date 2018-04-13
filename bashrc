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

if [ "$color_prompt" = yes ]; then
    red="\[\033[0;31m\]"
    blue="\[\033[0;34m\]"
    blueLight="\[\033[1;34m\]"
    green="\[\033[0;32m\]"
    cyan="\[\033[0;36m\]"
    gray="\[\033[0;30m\]"
    yellow="\[\033[1;33m\]"
    white="\[\033[0;00m\]"
    # export PS1="$gray[\$(date +'%Y-%m-%d %H:%M:%S')] $red\u$blue@\h$gray:$green\W \$$white "
    # export PS1="${debian_chroot:+($debian_chroot)}$red\u$blue@\h$blue:$green\w$green\$$white "
    # export PS1="${debian_chroot:+($debian_chroot)}$red\u$blueLight@\h$blue:$green\W$green\$$white "
    # export PS1="${debian_chroot:+($debian_chroot)}$cyan\u$cyan@\h$cyan:$yellow\W$yellow \$$white "
    export PS1="${debian_chroot:+($debian_chroot)}$cyan\u$yellow:\W$green\$(parse_git_branch)$white \$ "
else
    export PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
fi

alias open='xdg-open'
