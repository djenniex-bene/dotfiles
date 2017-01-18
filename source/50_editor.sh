# Editing

if [[ ! "$SSH_TTY" ]] && is_osx; then
  export EDITOR='atom -w'
  export LESSEDIT='mvim ?lm+%lm -- %f'
else
  export EDITOR='vim'
fi

export VISUAL="$EDITOR"
alias q="$EDITOR"
alias qs="q $DOTFILES"
