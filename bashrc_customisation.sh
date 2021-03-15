export PS1='\[\033[02;32m\]\u@optix_desktop:\[\033[02;34m\]\w\$\[\033[00m\] '

alias ls='ls --color=auto'
alias vim='vi'
alias la='ls -a --color=auto'
alias ll='la -l -h --color=auto'
alias ..='cd ..; ls'

start_desktop() {
  /opt/TurboVNC/bin/vncserver -vgl -wm xfce4-session
}

kill_desktop() {
  if [ $# -eq 0 ]
  then
    echo "Provide the DISPLAY. eg :25"
  else
    /opt/TurboVNC/bin/vncserver -kill $1
  fi
}
