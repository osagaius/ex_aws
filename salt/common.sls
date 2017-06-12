# Common requirements
# Run like this: 
#   $ sudo salt-call --local state.sls common

common_packages:
  pkg.installed:
    - refresh: true
    - pkgs:
      - tmux
      - git
      - htop
      - vim
      - curl
      - conntrack
      - ntp
      - unzip
      {% if grains['os'] == 'Ubuntu' %}
      - haveged
      {% endif %}

{% if grains['os'] == 'Debian' %}
# add `ll` alias
/etc/profile:
  file.append:
    - text:
      - alias ll="ls -lah"
{% endif %}
