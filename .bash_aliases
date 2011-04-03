alias vim="vim --servername VIM"
alias ll="ls -l"
alias bu='rsync -Pav projects/ afshome/projects/'
journal () { editmoin http://localhost/journal/`date -I $*`; }
wiki () { editmoin http://localhost/$*; }
alias w="weather -mq -i EGPH"
