source $DOTFILES/source/50_php.sh

# Install PHP Dependencies
install_php_dependencies() {
  composer global require "drupal/coder:*"
  composer global require "phploc/phploc=*"
}

install_php_dependencies

#phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer
