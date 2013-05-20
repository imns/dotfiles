if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

PATH=$PATH:$HOME/bin

export PATH

#helpers
alias bp='sublime ~/.bash_profile'
alias sbp='source ~/.bash_profile'
alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'

#dev1vm
if [ $HOSTNAME = dev1vm.multi-ad.com ]; then
  alias co='cd /raid/0/www/docs/projects/marketplace/document_root'
  alias ant='cd /raid/0/www/docs/projects/marketplace/document_root/ant'
  alias kwikee='cd /raid/0/www/docs/projects/kwikee_systems/document_root'
  alias docs='cd /raid/0/www/docs'
  alias projects='cd /raid/0/www/projects'
  alias clients='cd /raid/0/www/docs/clients'
  alias prods='cd /raid/0/www/docs/prods'
if

#work
if [ $HOSTNAME = Nate-Smiths-iMac.local ]; then
  alias il='ssh illini@illini.webfactional.com'
  alias illini='cd ~/Sites/nodejs/illini'
  alias imns='ssh imns@imns.webfactional.com'
  alias cabooodle='ssh cabooodle@cabooodle.webfactional.com'
  alias cb='cd  ~/Sites/nodejs/cbnew'
  alias cbserver='cd ~/Sites/nodejs/cbnew && grunt server'
  alias cbopen='cd ~/Sites/nodejs/cbnew && open cbnew.sublime-project'
if


#git push
gp(){
  if [ $1 ]; then
    git add . && git commit -am $1 && git push origin master
  else
    echo "Please enter a commit message"
  fi
}

#go up n # of dirs
up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

#extracts all kinds of zip type files
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

test -r /sw/bin/init.sh && . /sw/bin/init.sh


#pretty colors
function prompt {

  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"

  __git_ps1() {
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf " (%s)" "${b##refs/heads/}";
    fi
  }

  ## enable fancy git prompt if possible
  if [ "$(type -t __git_ps1)" == "function" ]; then
    gitsection="$BOLD_ON$RED\$(__git_ps1 '(%s)')"
  else
    gitsection=""
  fi

  prefix=${debian_chroot:+($debian_chroot)}

export PS1="\n$GREENBOLD \u\[\033[00m\]: $CYAN\w\[\033[00m\] ${gitsection}\[\033[00m\] \\$ "
}
prompt


#ssh stuff from github
SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
    test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
