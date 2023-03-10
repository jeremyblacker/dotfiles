# Remove call to update_terminal_cwd if it doesn't exist.
#   (it is defined by Mac OSX etc/bashrc, but not if terminal is screen)
if [ "$(type -t update_terminal_cwd)" != function ]; then
  export PROMPT_COMMAND="${PROMPT_COMMAND//update_terminal_cwd/:}"
fi

for script in $(ls ${HOME}/.bash.d/*.sh); do
    source $script
done;
#source ${HOME}/.bash.d/prompt.sh
# if [ -r "${HOME}/.bash.d/work.sh" ]; then
#     . $HOME/.bash.d/work.sh
# fi
export EDITOR=emacs
alias ll="ls -l"
alias deepsleep="sudo pmset -b hibernatemode 25;pmset -g | grep hibernatemode"
alias lightsleep="sudo pmset -b hibernatemode 3 ;pmset -g | grep hibernatemode"
alias sleepmode="pmset -g | grep hibernatemode"
alias sha1="/usr/bin/openssl sha1"
export PERL5LIB=$HOME/perl5/Library/Perl/Updates/5.10.0:$HOME/perl5/lib/perl5/site_perl:$HOME/perl5:/Users/ublacj2/perl5/lib/perl5:$PERL5LIB
export PATH=/Users/ublacj2/.gem/ruby/1.8/bin:$PATH
#export PATH=/usr/local/texlive/2013basic/bin/x86_64-darwin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
#export PATH=/opt/cisco/anyconnect/bin:$PATH
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
#export TEX=/usr/local/texlive/2013basic/bin/x86_64-darwin/tex

# Use GNU grep (with PCRE!), egrep, fgrep from Brew 
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

alias grep="grep --color"
alias egrep="grep -E --color"
alias list-listening-ports="sudo lsof -i -P | grep -i 'listen'"
alias list-listening-ports-linux="netstat -atp tcp | grep -i 'listen'"
alias check-tcp-ports="sudo lsof -iTCP -sTCP:LISTEN -n -P"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
   . "/usr/local/etc/profile.d/bash_completion.sh"
   . "${HOME}/.bash.d/1password-cli-completion.sh"
fi
complete -C /usr/local/bin/terraform terraform

function myfind {
    find . -path './.git' -prune -o -exec grep -H "$1" {} \;
}
alias findack="find -type f -print0 | xargs -0 ack"
alias sqlplus='rlwrap -b "" sqlplus'

alias cd="pushd"
alias bd="popd"

alias gpgsign="gpg2 -e -r 'Jeremy Blacker <jblacker@brandeis.edu>'"


function revert-sed {
    for F in `ls | grep '.bak'`; do mv -v $F `echo $F | sed 's/\.bak//'`; done
}

function emacs-clean  {
    find . \( -path '*.emacs.d*' -o -path '*/Library/*' \) -prune -o -type f \( -name '*~' -o -name '\#*' -o -name '\.\#*' \) -exec rm {} \; -print
}

# e.g. `ps -ef | grep 'searchter[m]' | killit`
function killit {
    while read -r process
    do
	[ -n "$process" ] && kill `echo $process | grep -v grep | awk '{print $2}'`
    done
}

# http://osxdaily.com/2011/12/10/disable-or-enable-spotlight-in-mac-os-x-lion/
alias start-spotlight="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist"

alias restart-airplay-audio="sudo killall coreaudiod"

#Display Your Current Port Forwarding Rules
alias show-port-forwarding="sudo pfctl -s nat"
alias test-pfctl="sudo pfctl -v -n -f /etc/pf.conf"
alias test-iptables="sudo pfctl -v -n -f /etc/pf.conf"

export HISTFILESIZE=100000
export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
export HISTCONTROL=ignoredups
# time be time, mon
export HISTTIMEFORMAT='%F %T '
# collapse multiline commands into one history entry
shopt -s cmdhist
# append to the history file instead of overwriting
shopt -s histappend
# Prevent the occasional overwriting of the same line 
shopt -s checkwinsize



# Properly iterate over list of strings containing spaces
# old_IFS="$IFS"
# IFS=$'\n'
# for R in $(lookupMailList <mail-list>@<doman>.com | awk -F': ' '{print $2}'); do echo "$R"; done;
# LIST="$(lookupMailList <mail-list>@<domain>.com | awk -F': ' '{print $2}' | awk -F, '{print $1}')"
# for R in $LIST; do ldapsearch -LLL -x -h madc01 -b "ou=UK,ou=Accounts,dc=<domain>,dc=com" "$R" sAMAccountName | grep -v "dn"; done;

# Another Join:
# # tr '\n' ' '
# like sed, but I don't need to capture everything I'm not subsitituting 
function join {
    local IFS="$1"
    shift
    echo "$*"
}

alias snv="svn"

alias svndiff="svn diff --diff-cmd=colordiff"
alias snvdiff="svn diff --diff-cmd=colordiff"
 
alias insecure-chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --allow-running-insecure-content > /dev/null 2>&1 &"

function killssh {
    if [ -n "$1" ]
    then
	kill $(ps -ef | grep "ss[h].*${1}" | grep -v 'agent' | awk '{print $2}')
    else
	kill $(ps -ef | grep 'ss[h]' | grep -vE '(agent|emacs|vim)' | awk '{print $2}')
    fi
}

function revert-sed {
    for F in `ls | grep '.bak'`; do mv -v $F `echo $F | sed 's/\.bak//'`; done
}

# Takes in a username and runs ssh commands as that user
function sudosvn {
    svn --config-option "config:tunnels:ssh=$SVN_SSH ssh -l $1"
}


export SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | egrep '/usr/bin/ssh-agent$' > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi


alias restart-camera="sudo killall VDCAssistant"

# Where is the perl library located?
# perl -MTAP::Harness::JUnit -e'print $_ . " => " . $INC{$_} . "\n" for keys %INC' | egrep -i 'tap|harness|object|base


alias pbcopy="pbcopy;echo"
alias clear-dns-cache="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"


alias wifi-on="/usr/sbin/networksetup -setairportpower en0 on"
alias wifi-off="/usr/sbin/networksetup -setairportpower en0 off"

alias move-resume="mv $HOME/Downloads/Jeremy\ Blacker\ Resume.pdf $HOME/Google\ Drive/My\ Drive/Documents/Career/resumes/jeremy_blacker_resume.pdf"
alias grep-git-blame-timestamps="grep -Eo '[0-9]{4}(-[0-9]{2}){2} ( |[0-9])[0-9]:[0-9]{2}:[0-9]{2} -[0-9]{4}'"

# For use on a remote server
function getssh {
    commands="$(export | grep SSH)"
    screen -X register . "${commands}\n"
}

alias jeremy-firefox="nohup /Applications/Firefox.app/Contents/MacOS/firefox --no-remote --profile \"$HOME/Library/Application Support/Firefox/Profiles/omzg480m.default-release\" >/dev/null &"

# Complains on shell startup. This makes it so that ctrl-s doesn't freeze things up when trying to cycle forward previous commands
# Need to better understand what this command actually does
# stty -ixon
