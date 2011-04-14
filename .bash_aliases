alias vim="vim --servername VIM"
alias bu='rsync -Pav projects/ afshome/projects/'
journal () { editmoin http://localhost/journal/`date -I $*`; }
wiki () { editmoin http://localhost/$*; }
alias w="weather -mq -i EGPH"

alias ll='ls -lh'
export one="pazz@0x7fffffff.net"
alias texcleanup="tc"
alias tc="for f in *bbl *toc *aux *log *blg *out *~; do rm \$f 2>/dev/null; done"

alias o="ssh -X $one"
alias s='ssh -X -L8888:129.215.90.80:80 s0976898@ssh.inf.ed.ac.uk'
alias trc='transmission-remote-cli -c `~/bin/getpwd Transmission`@openwrt'
alias gmutt="mutt -F ~/.muttrc.gmail"
