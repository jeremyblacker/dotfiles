function killssh {
    if [ -n "$1" ]
    then
	kill $(ps -ef | grep "ss[h].*${1}" | grep -v 'agent' | awk '{print $2}')
    else
	kill $(ps -ef | grep 'ss[h]' | grep -vE '(agent|emacs|vim)' | awk '{print $2}')
    fi
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
    ps -ef | grep ${SSH_AGENT_PID} | grep -E '/usr/bin/ssh-agent$' > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# For use on a remote server
function getssh {
    commands="$(export | grep SSH)"
    screen -X register . "${commands}\n"
}
