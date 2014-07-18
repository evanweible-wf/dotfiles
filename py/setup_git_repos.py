# system imports
import json
import os

# internal imports
import log
from constants import ZSH
from process import Process


def workspace_exists(workspace_path):
    return os.path.exists(workspace_path)


def repo_exists(workspace_path, repo):
    return os.path.exists(os.path.join(workspace_path, repo['name']))


def remote_exists(workspace_path, repo, remote):
    repo_path = os.path.join(workspace_path, repo['name'])
    return Process('git remote | grep %s' % remote['name'], cwd=repo_path, silent=True).run().succeeded()


def setup_git_repo(workspace_path, repo):
    repo_path = os.path.join(workspace_path, repo['name'])
    log.info('cloning "%s" repo (%s) into %s' % (repo['name'], repo['origin'], repo_path))

    command = 'git clone %s %s' % (repo['origin'], repo['name'])
    Process(command,
            cwd=workspace_path,
            error_msg='cloning "%s" (%s) failed' % (repo['name'], repo['origin']),
            exit_on_fail=True).run()
    log.success('%s repo (%s) cloned into %s' % (repo['name'], repo['origin'], repo_path))

    if 'upstream' in repo:
        log.info('adding upstream to %s' % repo['name'])
        if not remote_exists(workspace_path, repo, {'name': 'upstream'}):
            upstream = repo['upstream']
            command = 'git remote add upstream %s && git fetch %s' % (upstream, upstream)
            Process(command,
                    cwd=repo_path,
                    error_msg='adding upstream to %s failed' % repo['name'],
                    exit_on_fail=True).run()
            log.success('added upstream to %s' % repo['name'])
        else:
            log.success('upstream already exists')


def add_git_remotes(workspace_path, repo):
    if 'remotes' not in repo or len(repo['remotes']) == 0:
        return

    for remote in repo['remotes']:
        if not remote_exists(workspace_path, repo, remote):
            log.info(' - adding remote "%s" to %s' % (remote['name'], repo['name']))
            repo_path = os.path.join(workspace_path, repo['name'])
            Process('git remote add %s %s && git fetch %s' % (remote['name'], remote['url'], remote['name']),
                    cwd=repo_path,
                    exit_on_fail=True).run()
            log.success(' - remote "%s" added to %s' % (remote['name'], repo['name']))


def configure_git_repo(workspace_path, repo):
    if 'gitconfig' not in repo:
        return

    repo_path = os.path.join(workspace_path, repo['name'])

    for key, value in repo['gitconfig'].iteritems():
        current_value = Process('git config %s' % key, cwd=repo_path, exit_on_fail=False).run().stdout.strip()
        if current_value != value:
            log.info(' - setting %s to "%s"' % (key, value))
            Process('git config %s "%s"' % (key, value), cwd=repo_path, exit_on_fail=True).run()
            log.success(' - %s set to "%s"' % (key, value))


def setup_git_workspace(workspace):
    if not workspace_exists(workspace['path']):
        os.makedirs(workspace['path'])

    for repo in workspace['repos']:
        if not repo_exists(workspace['path'], repo):
            setup_git_repo(workspace['path'], repo)
        else:
            log.success('%s %s' % (u'\u2713', repo['name']))

        add_git_remotes(workspace['path'], repo)
        configure_git_repo(workspace['path'], repo)


def run():
    git_workspaces = json.load(open(os.path.join(ZSH, 'git/repos.json')))
    for workspace in git_workspaces:
        setup_git_workspace(workspace)


if __name__ == '__main__':
    run()