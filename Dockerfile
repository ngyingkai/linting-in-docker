FROM koalaman/shellcheck-alpine

RUN apk update && apk add bash

# Copy linting script    
COPY scripts/code_linting.sh /linting/scripts/

RUN chmod 777 /linting

WORKDIR /linting

ENTRYPOINT [ "/linting/scripts/code_linting.sh" ]