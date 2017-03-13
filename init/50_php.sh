source $DOTFILES/source/50_php.sh

packages=(
  drupal/coder
  drupal/console
  phploc/phploc
)

# Install PHP Dependencies
install_php_dependencies() {
  packages=($(setdiff "${packages[*]}" "$(composer global show -N)"))
  if (( ${#packages[@]} > 0 )); then
    e_header "Installing Composer packages: ${packages[*]}"
    for packages in "${packages[@]}"; do
      composer global require $packages
    done
  fi
}

install_php_dependencies


e_header "Updating Composer packages"
composer global update

#phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
