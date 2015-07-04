# reload changes to dotfiles
alias reload!='. ~/.zshrc'

# basic aliases
alias cl='clear'

# workspaces
alias dev='cd ~/dev/'
alias devw='cd ~/dev/workiva/cp'
alias devc='cd ~/dev/config'
alias devp='cd ~/dev/ekweible'
alias devs='cd ~/dev/sandbox'

# projects
alias dotfiles='cd ~/dev/config/dotfiles'
alias secrets='cd ~/dev/config/secrets'
alias sky='cd ~/dev/workiva/other/bigsky'

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
# function run() {
#    python ~/dev/ekweible/scripts/runserver.py "`pwd`" "$@"
# }

# bigsky aliases
alias runserver='python ~/dev/workiva/other/scripts/runserver.py'
alias erasereset='sky && python tools/erase_reset_data.py --admin=evan.weible@workiva.com --password=n'
