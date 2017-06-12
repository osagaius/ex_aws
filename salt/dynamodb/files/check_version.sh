#!/bin/bash

URL=$1
DYNAMODB_PATH=$2
FULL_URL=$(curl -sI $1 | awk '/Location/{gsub(/Location: /, ""); print}')
LATEST_VERSION=$(echo $FULL_URL | cut -d _ -f 3 | sed 's/\..*//')
VERSION_FILE=$2/VERSION
INSTALLED_VERSION=$([[ -f $VERSION_FILE ]] && cat $VERSION_FILE || echo "NOT INSTALLED")

# if we couldn't extract location from headers (i.e., there's a problem with
# the http request) to get the latest version, bail out without producing
# output so we don't indicate there are changes
[[ $LATEST_VERSION = "" ]] && exit 0

# check the versions and if they're different, produce output to satisfy the
# stateful behavior of cmd.run
[[ $INSTALLED_VERSION = $LATEST_VERSION ]] || echo "changed=true comment='new version is available'"
