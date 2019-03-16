#!/bin/bash

set -e

# THIS REQUIRES TO LOAD NVM
# exec bash

# if [ -n "$NPM_AUTH_TOKEN" ]; then
#   # Respect NPM_CONFIG_USERCONFIG if it is provided, default to $HOME/.npmrc
#   NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG-"$HOME/.npmrc"}"
#   NPM_REGISTRY_URL="${NPM_REGISTRY_URL-registry.npmjs.org}"

#   # Allow registry.npmjs.org to be overridden with an environment variable
#   printf "//%s/:_authToken=%s\\nregistry=%s" "$NPM_REGISTRY_URL" "$NPM_AUTH_TOKEN" "$NPM_REGISTRY_URL" > "$NPM_CONFIG_USERCONFIG"
#   chmod 0600 "$NPM_CONFIG_USERCONFIG"
# fi

echo '"$@"' | bash

for ARG in "$@"; do
  echo '"$ARG"'| bash
done
