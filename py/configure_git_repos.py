# system imports
import json
import os

# internal imports
import log
from constants import ZSH
from process import Process


def run():
    git_repos = json.load(open(os.path.join(ZSH, 'git/repos.json')))


if __name__ == '__main__':
    run()