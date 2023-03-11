shopt -s extglob
# Remove call to update_terminal_cwd if it doesn't exist.
#   (it is defined by Mac OSX etc/bashrc, but not if terminal is screen)
if [ "$(type -t update_terminal_cwd)" != function ]; then
  export PROMPT_COMMAND="${PROMPT_COMMAND//update_terminal_cwd?(;)/}"
fi

for script in $(ls ${HOME}/.bash.d/*.sh); do
    source $script
done;

export PATH=$HOME/bin:$PATH

if [ -n $(which emacs) ]; then
    export EDITOR=emacs
elif [ -n $(which vim) ]; then
    export EDITOR=vim
elif [ -n $(which vi) ]; then
    export EDITOR=vi
else
    echo 'NO EMACS, NO VIM, and NO VI?!?!?!?!'
fi
alias ll="ls -l"
alias grep="grep --color"
alias egrep="grep -E --color"
alias grep-bashrc='grep -hE ~/.bashrc ~/.bash.d/* --exclude 1password-cli-completion.sh -e'
alias cd="pushd"
alias bd="popd"
alias gpgsign="gpg2 -e -r 'Jeremy Blacker <jblacker@brandeis.edu>'"
alias grep-git-blame-timestamps="grep -Eo '[0-9]{4}(-[0-9]{2}){2} ( |[0-9])[0-9]:[0-9]{2}:[0-9]{2} -[0-9]{4}'"
# alias sqlplus='rlwrap -b "" sqlplus'

## Network stuff
alias list-listening-ports="sudo lsof -i -P | grep -i 'listen'"
alias list-listening-ports-netstat="netstat -atp tcp | grep -i 'listen'"
alias list-tcp-ports="sudo lsof -iTCP -sTCP:LISTEN -n -P"
# Display Your Current Port Forwarding Rules
alias show-port-forwarding="sudo pfctl -s nat"
alias test-pfctl="sudo pfctl -v -n -f /etc/pf.conf"
alias test-iptables="sudo pfctl -v -n -f /etc/pf.conf"


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Don't remember the purpose of this
alias findack="find -type f -print0 | xargs -0 ack"

function myfind {
    find . -path './.git' -prune -o -exec grep -H "$1" {} \;
}

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


## Change input field separater
## By default, IFS is set to $' \t\n'
## If you `unset IFS`, it will act as if it had the default value
# $ echo -n "$IFS" | cat -et  # `cat -et` displays spaces as '^', tabs as '\t', and newlines as '$'
# ^I$
# $ for F in $(echo -e "hello you\nHi me"); do echo $F; done;
# hello
# you
# Hi
# me
# $ IFS=$'\n'
# $ for F in $(echo -e "hello you\nHi me"); do echo $F; done;
# hello you
# Hi me


# Another Join:
# # tr '\n' ' '
# like sed, but I don't need to capture everything I'm not subsitituting

function join {
    local IFS="$1"
    shift
    echo "$*"
}
 

# Where is the perl library located?
# perl -MTAP::Harness::JUnit -e'print $_ . " => " . $INC{$_} . "\n" for keys %INC' | grep -Ei 'tap|harness|object|base'


alias grep-git-blame-timestamps="grep -Eo '[0-9]{4}(-[0-9]{2}){2} ( |[0-9])[0-9]:[0-9]{2}:[0-9]{2} -[0-9]{4}'"


# Complains on shell startup. This makes it so that ctrl-s doesn't freeze things up when trying to cycle forward previous commands
# Need to better understand what this command actually does
# stty -ixon
