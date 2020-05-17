# .bashrc
iatest=$(expr index "$-" i)

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

#-----------------------------------------------------------------------            
#                           PATH
#-----------------------------------------------------------------------

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#-----------------------------------------------------------------------            
#                           VARIABLES
#-----------------------------------------------------------------------

export VISUAL=vim
export EDITOR=vim
export BROWSER=firefox

#-----------------------------------------------------------------------            
#                           ALIASES
#-----------------------------------------------------------------------

if [[ -f ~/.alias ]];then
        . ~/.alias
fi

#-----------------------------------------------------------------------            
#                           ENVIRONMENT
#-----------------------------------------------------------------------

# Disable the bell
if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

#-----------------------------------------------------------------------            
#                           FUNCTIONS
#-----------------------------------------------------------------------
getnews () {
  curl https://newsapi.org/v2/top-headlines -s -G \
    -d sources=$1 \
    -d apiKey= \
    | jq -r '.articles[] | .title, .url, ""'
}

hackernews () {
  echo "News from Hacker News:"
  getnews hacker-news
}
