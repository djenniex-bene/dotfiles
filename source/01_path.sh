paths=(
  ~/.local/bin
  $DOTFILES/bin
  /usr/local/opt/curl/bin
  /Applications/Visual Studio Code.app/Contents/Resources/app/bin
)

export PATH
for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
done
unset p paths
