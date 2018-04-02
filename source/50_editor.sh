# Editing

export EDITOR=vim

if [[ ! "$SSH_TTY" ]] && is_osx; then
  # [[ ! "$TMUX" ]] && EDITOR=mvim
  EDITOR=mvim
  export EDITOR='atom -n -w'
  export LESSEDIT='mvim ?lm+%lm -- %f'
  export GIT_EDITOR='atom -n -w'
fi

export VISUAL="$EDITOR"

function q() {
  if [[ -t 0 ]]; then
    $EDITOR "$@"
  else
    # Read from STDIN (and hide the annoying "Reading from stdin..." message)
    $EDITOR - > /dev/null
  fi
}
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q $DOTFILES"
