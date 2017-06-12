# Dev requirements
# Run like this: 
#   $ sudo salt-call --local state.sls dev_tools

dev_packages:
  pkg.installed:
    - refresh: true
    - pkgs:
      - tmux
      - htop
      - build-essential
      - vim
      - curl
      - screen
      - jq
      - libssl-dev
      - python-dev
      - libncurses5-dev
      - ntp
      - ack-grep
      - unzip

# we need newest git to clone RTJ and get manifests.xml
git_core_ppa:
  pkgrepo.managed:
    - ppa: git-core/ppa
  pkg.latest:
    - name: git
    - refresh: True
