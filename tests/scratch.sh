#!/bin/bash
# Scratchpad for testing functionalities

# getops

func() {
  local OPTIND=1
  local opt
  local rem_args=()
  local a=false

  while getopts ":vf:ar:" opt; do
    case "$opt" in
      v)
        echo "Verbose mode (-$opt)"
        ;;
      f)
        echo "File required (-$opt): $OPTARG"
        ;;
      a)
        a=true
        echo "All mode (-a): $a"
        ;;
      r)
        echo "Recurse files (-r): $OPTARG"
        ;;
      \?) # invalid options
        echo "Invalid option: -$OPTARG" >&2
        ;;
      :) # missing arguments
        echo "Option -$OPTARG requires an argument" >&2
        ;;
    esac
  done
  shift $((OPTIND-1))

  # store and print remaining arguments
  if [[ ! -z "${@}" ]]; then
    rem_args=("${@}")
    echo "Remaining args: ${rem_args[@]}"
  fi

}

func "$@"