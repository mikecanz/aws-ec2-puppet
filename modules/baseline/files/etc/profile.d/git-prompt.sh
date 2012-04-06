alias gd="git difftool --tool=vimdiff"
alias gl="git log -n 20 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %an' --abbrev-commit --date=relative"
alias gs="git status"
alias gco="git checkout"
alias gci="git commit"
alias gb="git branch"
alias gba="git branch -a"

export SERVER_NAME=`hostname -f`

if [ -e /var/lib/puppet/ec2_instance_tags ]
then
    export SERVER_NAME=`cat /var/lib/puppet/ec2_instance_tags | grep Name | sed s/Name://`
fi

export PATH=$PATH:$HOME/env
export PS0='\[\e[0;36m\]\t\[\e[0m\] \[\e[0;33m\]\u@\[\e[0m\]\[\e[0;31m\]$SERVER_NAME\[\e[0m\] {\[\e[1;33m\]\w\[\e[0m\]}\[\e[0;36m\]%{(%b\[\e[1;37m\]%m\[\e[0;36m\])[%u%c%f%t\[\e[0;36m\]]%}\[\e[0m\]$'
export PROMPT_COMMAND=$PROMPT_COMMAND'
export PS1=$(gitprompt.pl statuscount=1 u=%[%e[31m%] c=%[%e[32m%] f=%[%e[1\;37m%])'
