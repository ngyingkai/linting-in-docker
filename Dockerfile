# based on official shellcheck image
FROM koalaman/shellcheck-alpine

# install bash to run bash script
RUN apk update && apk add bash

# copy linting script
COPY scripts/shell_linting.sh /usr/local/bin

# directory to mount folder to lint
WORKDIR /linting

# script will run shell_linting.sh by default
ENTRYPOINT [ "shell_linting.sh" ]