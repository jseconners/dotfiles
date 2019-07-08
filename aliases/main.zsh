
# reload
alias reload="source $HOME/.zshrc"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# List all files colorized in long format
alias l="ls -lF"

# List all files colorized in long format, including dot files
alias la="ls -laF"

# List only directories
alias lsd="ls -lF | grep --color=never '^d'"

alias ls="command ls"
