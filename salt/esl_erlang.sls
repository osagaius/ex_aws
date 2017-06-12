# Install Erlang from Erlang Solutions
# https://www.erlang-solutions.com
# Run like this:
#   $ sudo salt-call --local state.sls esl_erlang

erlang_solutions_repo:
  pkgrepo.managed:
    - humanname: Erlang Solutions Deb Repo
    - file: /etc/apt/sources.list.d/erlang-solutions.list

    {% if grains['oscodename'] == 'jessie' %}
    - name: deb http://packages.erlang-solutions.com/debian jessie contrib
    - key_url: http://packages.erlang-solutions.com/debian/erlang_solutions.asc

    {% elif grains['oscodename'] == 'wheezy' %}
    - name: deb http://packages.erlang-solutions.com/debian wheezy contrib
    - key_url: http://packages.erlang-solutions.com/debian/erlang_solutions.asc

    {% elif grains['oscodename'] == 'trusty' %}
    - name: deb http://packages.erlang-solutions.com/ubuntu trusty contrib
    - key_url: http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
    {% endif %}

esl-erlang:
  pkg.installed:
    - refresh: true
    {% if grains['oscodename'] == 'jessie' %}
    - version: '1:18.2'
    {% elif grains['oscodename'] == 'wheezy' %}
    - version: '1:17.5.3'
    {% elif grains['oscodename'] == 'trusty' %}
    - version: '1:18.2'
    {% endif %}

elixir:
  pkg.latest:
    - refresh: true
