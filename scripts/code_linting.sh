#!/bin/bash
#set -x

function print_help {
  echo '
This script / container does code linting for ******

Usage (as Docker container):
----------------------------
docker run --rm -v $(pwd):/linting -w /******/$(basename $(pwd)) ******

Usage (as script):
----------------------------
code_linting.sh

Hint: Run this script / container in a ******-* directory.

Options:
  -h           : print this help'
}

function shell_linting {
  SHELLCHECK_LOG="shellcheck_${LOG_PREFIX}.log"
  find . -not -path "./*******-dev-*/*" -not -path "./dist_src/*" -name '*.sh*' \
    -exec printf "%b\n" "\n#####################################################################\nChecking file {} \
    \n#####################################################################" \; \
    -exec shellcheck -x {} \; | tee -a "$SHELLCHECK_LOG"
}

while getopts "fhs" opt; do
  case $opt in
    s) SKIP_SHELLCHECK=1;;
    f) SKIP_FLAKE8=1;;
    h) print_help; exit 0;;
    *) error "Invalid option: $opt"; print_help; exit 1;;
  esac
done

LOG_PREFIX="$(date +'%Y%m%d-%H%M%S')"
if [[ $SKIP_SHELLCHECK -ne 1 ]]; then
  shell_linting
fi