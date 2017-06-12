# Salt HighState
# Run like this:
#    $ sudo salt-call --local state.highstate

base:
  '*':
    - common
    - fpm

  'roles:ex_aws':
    - match: grain
    - esl_erlang
    - dev_tools
    - nginx
    - dynamodb
