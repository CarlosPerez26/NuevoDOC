# ================================
# Variables básicas
# ================================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ================================
# Zsh settings
# ================================
setopt autocd
setopt correct
setopt extendedglob
setopt histignorealldups
setopt sharehistory

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  python
)

source $ZSH/oh-my-zsh.sh

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ================================
# Aliases útiles
# ================================
alias ll="ls -lah"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias vim="nvim"

# fd (porque Ubuntu lo llama fdfind)
alias fd="fdfind"

# ================================
# Gemini API switch (free / paid)
# ================================
alias gemini-free='export GEMINI_API_KEY="TU_API_KEY_GRATIS" && echo "🔓 Usando Gemini FREE" && gemini'
alias gemini-pro='export GEMINI_API_KEY="TU_API_KEY_PAGO" && echo "💳 Usando Gemini PRO" && gemini'

# ================================
# Prompt simple (sin oh-my-zsh aún)
# ================================
autoload -Uz promptinit
promptinit
prompt adam1

# ================================
# Tmux auto-start (solo si no estás ya en tmux)
# ================================
#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#  tmux attach -t BUFF1 || tmux new -s BUFF1
#fi

