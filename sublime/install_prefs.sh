#!/bin/sh

source $ZSH/scripts/includes.sh

info "Installing sublime preferences..."
ln -s "$ZSH/sublime/Preferences.sublime-settings" "~/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
success "Sublime preferences installed."