# PS1="\[\e[0;32m\][\[\033[31m\]\u@\[\033[34m\]\H\[\e[m\]()\w\[\e[0;32m\]]\$ \[\e[m\]"
# Color escape below. terminal redraws, resizes, etc, will break your prompt and the coloring often times. that's why you need to escape color even if you're putting a new color on after
# \[\e[0m\]
# \[ $color_setting \]
# \e[0; <- sets the style of the color. 0 is regular 1 is bold (which appears brighter)
# 35m  <- defines the color
# Black       0;30     Dark Gray     1;30
# Blue        0;34     Light Blue    1;34
# Green       0;32     Light Green   1;32
# Cyan        0;36     Light Cyan    1;36
# Red         0;31     Light Red     1;31
# Purple      0;35     Light Purple  1;35
# Brown       0;33     Yellow        1;33
# Light Gray  0;37     White         1;37

# PS1="\[\e[0;32m\][\[\e[0m\]\[\e[0;31m\]\u\[\e[0m\]\[\e[0;33m\]@\[\e[0m\]\[\e[1;34m\]\H\[\e[0m\]\[\e[1;31m\]:\[\e[0m\]\[\e[0;35m\]\w\[\e[0m\]\[\e[0;32m\]]\[\e[0m\]\n\[\e[0;32m\] \\$\[\e[0m\] "
# Brighter one below
# PS1="\[\e[1;33m\][\[\e[0m\]\[\e[1;31m\]\u\[\e[0m\]\[\e[1;32m\]@\[\e[0m\]\[\e[1;34m\]\H\[\e[0m\]\[\e[1;31m\]:\[\e[0m\]\[\e[1;35m\]\w\[\e[0m\]\[\e[1;33m\]]\[\e[0m\]\n\[\e[1;33m\] \\$\[\e[0m\] "

THIS_SCRIPT="${BASH_SOURCE[0]}"
DIR="$(dirname $THIS_SCRIPT)"

# do the color definitions only once
if [[ ${#ColorNames[*]} = 0 || -z "$IntenseBlack" || -z "$ResetColor" ]]; then
    source "$DIR/prompt-colors.sh"  
fi

PS1="\[\e[1;32m\][${ResetColor}${BrightRed}\u${ResetColor}${BrightYellow}@${ResetColor}${BrightBlue}local${ResetColor}${BrightRed}:${ResetColor}${Magenta}\w${ResetColor}${Green}]${ResetColor}\n ${Green}\\$ ${ResetColor}"
#PS1="${Green}[${ResetColor}${Red}\u${ResetColor}${Yellow}@${ResetColor}${Blue}\H${ResetColor}${Red}:${ResetColor}${Violet}\w${ResetColor}${Green}]${ResetColor}\n ${Green}\\$ ${ResetColor}"

# Moved to its own file since it's getting complex
# https://github.com/magicmonty/bash-git-prompt
bash_git_prompt_installation=''
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    bash_git_prompt_installation="/usr/local/opt/bash-git-prompt/share"
elif [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    bash_git_prompt_installation="$HOME/.bash-git-prompt"
fi

if [ -n "$bash_git_prompt_installation" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    
    # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
    # GIT_PROMPT_IGNORE_SUBMODULES=1 # uncomment to avoid searching for changed files in submodules

    # GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
    # GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files

    # GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files

    # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

    # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
    # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

    # as last entry source the gitprompt script
    GIT_PROMPT_THEME="Custom" # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
    GIT_PROMPT_THEME_FILE="$HOME/.bash.d/Jeremy.bgptheme"    
    # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
    __GIT_PROMPT_DIR="$bash_git_prompt_installation"
    source "${bash_git_prompt_installation}/gitprompt.sh"
    # . /usr/local/share/gitprompt.sh 
fi



# [12:04 PM] Friend: @jblacker also, if you end up using that prompt tool, this command is super helpful:
# [12:04 PM] Friend:
# $ git_prompt_help
# The git prompt format is <BRANCH><TRACKING><LOCALSTATUS>

# BRANCH is a branch name, such as "master" or "stage", a tag name, or commit
# hash prefixed with ':'.

# TRACKING indicates how the local branch differs from the
# remote branch.  It can be empty, or one of:

# ↑·N - ahead of remote by N commits
# ↓·M - behind remote by M commits
# ↑·N↓·M - branches diverged, other by M commits, yours by N commits

# LOCALSTATUS is one of the following:

# ✔ - repository clean
# ●N - N staged files
# ✖N - N files with merge conflicts
# ✚N - N changed but *unstaged* files
# …N - N untracked files
# ⚑N - N stash entries

# See "git_prompt_examples" for examples.
# [12:05 PM] Friend: until it seeps into your unconscious brain
# [12:06 PM] Friend: i have at least some measure of internal self-consistency
# [12:06 PM] Friend: i.e. i looked at the github readme for the git prompt thing and thought "oooh, this actually looks pretty nice"
