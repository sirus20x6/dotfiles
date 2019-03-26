# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

alias trizen='trizen --noedit --needed --noconfirm'

if [ -z "$ZPLG_HOME" ]; then
    ZPLG_HOME="${ZDOTDIR:-$HOME}/.zplugin"
fi
# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="false"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git svn git-flow gitfast git-extras )


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ls --color=al > /dev/null 2>&1 && alias ls='ls -F --color=al' || alias ls='ls -G'
alias ll='ls -lvA'
alias ..='cd ..'
alias ../..='cd ../..'
#alias find='~/scripts/fastfind'
alias 'sudo cd'='su && cd'
alias make=~/scripts/colorsmake
if [ -d /usr/lib/outproc/bin ]; then
    export PATH="/usr/lib/outproc/bin:$PATH"
fi

git_branch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }
#HOST='\033[02;36m\]\h'; HOST=' '$HOST
TIME='\033[01;31m\]\t \033[01;32m\]'
LOCATION=' \033[01;34m\]`pwd | sed "s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1_\2#g"`'
BRANCH=' \033[00;33m\]$(git_branch)\[\033[00m\]\n\$ '


RESET="\[\017\]"
NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
YELLOW="\[\033[33;1m\]"
WHITE="\[\033[37;1m\]"
SMILEY="${WHITE}:)${NORMAL}"
FROWNY="${RED}:(${NORMAL}"
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

# Throw it all together 
PS1="${RESET}${YELLOW}\h${NORMAL} \`${SELECT}\` ${YELLOW}>${NORMAL} "


PS1=$TIME$USER$HOST$LOCATION$BRANCH
PS2='\[\033[01;36m\]>'

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
export LC_CTYPE=en_US.UTF-8

#exec 9>&2
#exec 8> >(
#    while IFS='' read -r line || [ -n "$line" ]; do
#       echo -e "\033[31m${line}\033[0m"
#    done
#)
#function undirect(){ exec 2>&9; }
#function redirect(){ exec 2>&8; }
#trap "redirect;" DEBUG
#PROMPT_COMMAND='undirect;'
export HISTTIMEFORMAT="%d/%m/%y %T "

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add
fi

source '/home/sirus/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( \${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin load trapd00r/LS_COLORS

zplugin light zdharma/zui
zplugin light zdharma/zplugin-crasis
