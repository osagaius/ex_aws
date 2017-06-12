#!/bin/bash
cd $2

FULL_URL=$(curl -sI $1 | awk '/Location/{gsub(/Location: /, ""); print}')
LATEST_VERSION=$(echo $FULL_URL | cut -d _ -f 3 | sed 's/\..*//')

curl -LO $1
tar xzf dynamodb_local_latest.tar.gz && echo $LATEST_VERSION > VERSION
