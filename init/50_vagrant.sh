# Exit if Vagrant is not installed.
[[ ! "$(type -P vagrant)" ]] && e_error "Vagrant plugins need vagrant to install." && return 1

plugins=(
  vagrant-auto_network
  vagrant-bindfs
  vagrant-hostsupdater
  vagrant-share
  vagrant-vbguest
)

# Install vagrant plugins.
function vagrant_install_plugins() {
  plugins=($(setdiff "${plugins[*]}" "$(vagrant plugin list --machine-readable | grep plugin-name | cut -d , -f 4)"))
  if (( ${#plugins[@]} > 0 )); then
    e_header "Installing Vagrant plugins: ${plugins[*]}"
    for plugin in "${plugins[@]}"; do
      vagrant plugin install $plugin
    done
  fi
}

vagrant_install_plugins

e_header "Updating Vagrant modules"
vagrant plugin update
