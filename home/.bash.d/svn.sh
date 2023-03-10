alias snv="svn"
alias svndiff="svn diff --diff-cmd=colordiff"
alias snvdiff="svn diff --diff-cmd=colordiff"
# Takes in a username and runs ssh commands as that user
function sudosvn {
    svn --config-option "config:tunnels:ssh=$SVN_SSH ssh -l $1"
}
