#############################################################################
#                            TOOLS SOURCING                                 #
#############################################################################

# Eval Homebrew
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Source ASDF
source (brew --prefix asdf)/libexec/asdf.fish

# Source Oh My Posh
oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/spaceship.omp.json | source

# Source Zoxide
zoxide init fish | source

# Necessary for ASDF Postgres to link icu properly when using Homebrew
set -x LD_LIBRARY_PATH (brew --prefix icu4c)/lib $LD_LIBRARY_PATH
set -x LIBRARY_PATH (brew --prefix icu4c)/lib $LIBRARY_PATH

#############################################################################
#                                ALIASES                                    #
#############################################################################

# Vim/Nvim
alias vim='nvim'

# Changing "ls" to "eza"
alias ls='eza --icons --color=always --group-directories-first' 
alias ll='eza -l --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'
alias lt='eza -aT --icons --color=always --group-directories-first'

# Bottom CLI
alias gtop='btm'

# Bat (Cat replacement)
alias cat='bat --theme=base16'
