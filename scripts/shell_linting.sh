#!/bin/bash
#set -x

function print_help {
  echo '
This script / container do linting for shell scripts using ShellCheck.
This script will lint and will output a log file with the ShellCheck warnings/errors.

Usage (as Docker container):
----------------------------
docker run --rm -v $(pwd):/linting shell_lint:latest

Usage (as script):
----------------------------
code_linting.sh

Hint: Run this script / container in the root directory of your project.

Options:
  -h           : print this help'
}

function shell_linting {
  SHELLCHECK_LOG="shellcheck_${LOG_PREFIX}.log"
  find . -name '*.sh' \
    -exec printf "%b\n" "\n#####################################################################\nChecking file {} \
    \n#####################################################################" \; \
    -exec shellcheck -x {} \; | tee -a "$SHELLCHECK_LOG"
}

while getopts "h" opt; do
  case $opt in
    h) print_help; exit 0;;
    *) error "Invalid option: $opt"; print_help; exit 1;;
  esac
done

LOG_PREFIX="$(date +'%Y%m%d-%H%M%S')"

shell_linting