# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(
  caskroom/cask
  caskroom/fonts
  caskroom/versions
  homebrew/dupes
  homebrew/php
  homebrew/science
)
brew_tap_kegs

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Homebrew casks
casks=(
  # Applications
  a-better-finder-rename
  alfred
  atom
  bettertouchtool
  # box-sync Weirdness because of other install
  charles
  chromium
  docker
  #docker-toolbox
  easysimbl
  evernote
  fastscripts
  firefox
  flux
  google-chrome
  google-play-music-desktop-player
  hazel
  iterm2
  java
  # karabiner NOT SUPPORTED
  lastpass
  meld
  mysqlworkbench
  omnidisksweeper
  phpstorm
  #slack Weirdness because of other install
  spectacle
  the-unarchiver
  #totalfinder Nice, but you have to pay
  #tower Nice, but you have to pay
  #vagrant Vagrant 1.9.1 NFS mount is broken in MAC OS
  https://raw.githubusercontent.com/caskroom/homebrew-cask/b99d5280a3fae60bc18bf16ab314d9cc84e7af87/Casks/vagrant.rb
  virtualbox
  zoom
  # Drivers
  # Quick Look plugins
  betterzipql
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  quicknfo
  suspicious-package
  webpquicklook
  # Color pickers
  colorpicker-developer
  colorpicker-skalacolor
  # Fonts
  font-anonymous-pro
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cask cleanup
fi

# Work around colorPicker symlink issue.
# https://github.com/caskroom/homebrew-cask/issues/7004
cps=()
for f in ~/Library/ColorPickers/*.colorPicker; do
  [[ -L "$f" ]] && cps=("${cps[@]}" "$f")
done

if (( ${#cps[@]} > 0 )); then
  e_header "Fixing colorPicker symlinks"
  for f in "${cps[@]}"; do
    target="$(readlink "$f")"
    e_arrow "$(basename "$f")"
    rm "$f"
    cp -R "$target" ~/Library/ColorPickers/
  done
fi
