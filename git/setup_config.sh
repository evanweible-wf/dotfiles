#!/bin/sh

source $ZSH/scripts/includes.sh

function setup_gitconfig () {
    if ! [ -f "$ZSH/git/gitconfig.symlink" ]
    then
        info 'setup gitconfig'

        user '- What is your github author name?'
        read -e git_authorname
        user '- What is your github author email?'
        read -e git_authoremail

        sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" $ZSH/git/gitconfig.symlink.example > $ZSH/git/gitconfig.symlink

        success 'gitconfig completed'
    fi
}

setup_gitconfig
