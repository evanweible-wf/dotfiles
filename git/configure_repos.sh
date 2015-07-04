#!/bin/sh

source $ZSH/scripts/includes.sh

configure_git_repos () {
    user "- do you want to configure your git repositories? (Y/n)"
    read -n 1 action
    br
    if [ "$action" == 'n' ]
    then
        return
    fi

    python2.7 $ZSH/py/configure_git_repos.py

    if [ "$?" != 0 ]
    then
        exit
    fi

    success "git repositories configured"
    sh gitboot
}

configure_git_repos
