case "$TERM" in
    xterm) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    red="\[\033[0;31m\]"
    blue="\[\033[0;34m\]"
    green="\[\033[0;32m\]"
    gray="\[\033[0;30m\]"
    white="\[\033[0;00m\]"
    # export PS1="$gray[\$(date +'%Y-%m-%d %H:%M:%S')] $red\u$blue@\h$gray:$green\W \$$white "
    export PS1="${debian_chroot:+($debian_chroot)}$red\u$blue@\h$blue:$green\w$green\$$white "
else
    export PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
fi

alias open='xdg-open'
