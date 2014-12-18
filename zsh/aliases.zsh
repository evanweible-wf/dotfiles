# reload changes to dotfiles
alias reload!='. ~/.zshrc'

# basic aliases
alias cl='clear'

# workspaces
alias dev='cd ~/dev/'
alias devw='cd ~/dev/workiva/cp'
alias devc='cd ~/dev/config'
alias devp='cd ~/dev/ekweible'

# projects
alias alfred='cd ~/dev/ekweible/alfred-workflows'
alias class='cd ~/dev/ekweible/class'
alias dotfiles='cd ~/dev/config/dotfiles'
alias ekw='cd ~/dev/ekweible/ekweible.github.io'
alias jspubsub='cd ~/dev/wf/w-js-pubsub'
alias portfolio='ekw'
alias ra='cd ~/dev/wf/richapps'
alias secrets='cd ~/dev/config/secrets'
alias sky='cd ~/dev/wf/bigsky'
alias spike='cd ~/dev/wf/wf-js-app-shell-spike'
alias wallboard='cd ~/dev/ekweible/wallboard.me'
alias wb='cd ~/dev/wf/web-bones'

# check for virtualenv upon entering directories
has_virtualenv() {
    if [ -e .venv ]; then
        workon `cat .venv`
    fi
}
venv_cd () {
    builtin cd "$@" && has_virtualenv
}
alias cd="venv_cd"

# gae aliases
function run() {
    python ~/dev/ekweible/scripts/runserver.py "`pwd`" "$@"
}

# bigsky aliases
alias erasereset='sky && python tools/erase_reset_data.py --admin=evan.weible@workiva.com --password=n'
