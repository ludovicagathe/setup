#!/bin/bash
# Scratchpad for testing functionalities

detect_version () {
  local VERSION
  local MESSAGE
  if [[ "$1" =~ ^[v]?[0-9]+(\.[0-9]+)?{2,3}(\-([\.0-9a-zA-Z]+))?$ ]]; then
    VERSION="$1"
    if [[ "${1:0:1}" != "v" ]]; then
      VERSION="v""$VERSION"
    fi
  else
    return 1
  fi
  if [[ ! -z $2 ]]; then
    MESSAGE=$2
  fi
  echo "Version: $VERSION"
  echo "Message: $MESSAGE"
}

detect_version $@