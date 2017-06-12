# Elasticsearch
# Run like this:
#   $ sudo salt-call --local state.sls elasticsearch

java_8:
  pkgrepo.managed:
    - ppa: openjdk-r/ppa
  pkg.installed:
    - name: openjdk-8-jre
    - refresh: True

elasticsearch_group:
  group.present:
    - name: elasticsearch

/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://files/elasticsearch.yml
    - user: root
    - group: elasticsearch
    - mode: 640
    - require:
      - group: elasticsearch

elasticsearch:
  pkgrepo.managed:
    - humanname: Elasticsearch
    - name: deb http://packages.elastic.co/elasticsearch/2.x/debian stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - key_url: https://packages.elastic.co/GPG-KEY-elasticsearch
    - require_in:
      - pkg: elasticsearch
    - require:
      - pkg: openjdk-8-jre
  pkg.installed:
    - name: elasticsearch
    - refresh: True
    - require:
      - pkg: openjdk-8-jre
  service.running:
    - enable: True
    - watch:
      - file: /etc/elasticsearch/elasticsearch.yml
    - require:
      - pkg: elasticsearch
