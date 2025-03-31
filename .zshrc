parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# for case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# for git autocomplete
autoload -Uz compinit && compinit

COLOR_DEF='%f'
COLOR_USR='%F{141}'
COLOR_DIR='%F{230}'
COLOR_GIT='%F{203}'
# About the prefixed `$`: https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_03.html#:~:text=Words%20in%20the%20form%20%22%24',by%20the%20ANSI%2DC%20standard.
NEWLINE=$'\n'
# Set zsh option for prompt substitution
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR} %n ${COLOR_DIR}%d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}%% '

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin" 

alias gm='git fetch && git pull'
alias gco='git checkout'
alias gcmt='git commit -m'
alias gpsh='git push'
alias szsh='source ~/.zshrc'
alias ozsh='code ~/.zshrc'
alias runc='zsh run.sh'
alias bscr='zsh build-script.sh'
alias brel='zsh build-release.sh'
alias bdebug='zsh build-debug.sh'
alias brun='zsh build-script.sh && zsh run.sh'
alias vim='nvim'
alias toconf='cd ~/.config/'

# bun completions
[ -s "/Users/jerrygao/.bun/_bun" ] && source "/Users/jerrygao/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:/usr/local/mongodb-macos-aarch64-8.0.3/bin"
