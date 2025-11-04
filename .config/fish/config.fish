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

# Nasty hack for VSCode (not working by default for some reason)
function code; set p (which code); $p $argv; end

# Custom function to amend commits without changing dates
function git-safe-amend
  set orig_author_date (git show -s --format=%aI HEAD)
  set orig_committer_date (git show -s --format=%cI HEAD)
  env GIT_COMMITTER_DATE="$orig_committer_date" git commit --amend --no-edit --date "$orig_author_date"
end
