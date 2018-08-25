paths=(
  ~/.local/bin
  $DOTFILES/bin
)

export PATH
for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
done
PATH=/usr/local/opt/curl/bin:"$(path_remove /usr/local/opt/curl/bin)"
unset p paths
