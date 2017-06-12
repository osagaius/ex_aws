# Common requirements
fpm_deps:
  pkg.installed:
    - refresh: true
    - pkgs:
      - ruby-dev
      - gcc

fpm:
  gem.installed
