# Dev requirements
# Run like this:
#   $ sudo salt-call --local state.sls nginx

nginx:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: nginx
      #- file: /etc/nginx/nginx.conf
