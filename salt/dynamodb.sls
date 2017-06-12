{% set dynamodb_path = '/opt/dynamodb' %}
{% set url = 'http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz' %}
{% set user = 'nobody' %}
{% set group = 'nogroup' %}
{% set port = 8088 %}


java_is_installed:
  pkg.installed:
    - name: openjdk-7-jre-headless


installed_dynamodb_is_latest:
  cmd.script:
    - source: salt://dynamodb/files/check_version.sh
    - args: {{ url }} {{ dynamodb_path }}
    - stateful: True


dynamodb_path_exists:
  file.directory:
    - name: {{ dynamodb_path }}
    - user: {{ user }}
    - group: {{ group }}


dynamodb_is_installed:
  cmd.wait_script:
    - source: salt://dynamodb/files/install.sh
    - args: {{ url }} {{ dynamodb_path }}
    - cwd: {{ dynamodb_path }}
    - require:
      - file: dynamodb_path_exists
      - pkg: java_is_installed
    - watch:
      - cmd: installed_dynamodb_is_latest


dynamodb_service_is_configured:
  file.managed:
    - name: /etc/init/dynamodb.conf
    - source: salt://dynamodb/templates/dynamodb.service.jinja
    - template: jinja
    - context:
        dynamodb_path: {{ dynamodb_path }}
        user: {{ user }}
        group: {{ group }}
        port: {{ port }}
    - require:
      - cmd: dynamodb_is_installed


dynamodb_nginx_vhost_is_configured:
  file.managed:
    - name: /etc/nginx/conf.d/dynamodb.conf
    - source: salt://dynamodb/templates/dynamodb-vhost.conf.jinja
    - template: jinja
    - context:
        port: {{ port }}
    - require:
      - file: dynamodb_service_is_configured
      - pkg: nginx
    - watch_in:
      - service: nginx


dynamodb_is_running:
  service.running:
    - name: dynamodb
    - enable: true
    - watch:
      - cmd: dynamodb_is_installed
