#!/bin/sh

set -e

local_registry="http://0.0.0.0:4873"

# create .npmrc
NPM_AUTH_TOKEN="test_token" 
VERDACCIO_CONFIG_USERCONFIG="${VERDACCIO_CONFIG_USERCONFIG-"$HOME/.npmrc"}"
VERDACCIO_REGISTRY_URL="${VERDACCIO_REGISTRY_URL-0.0.0.0:4873}"
VERDACCIO_STRICT_SSL="${VERDACCIO_STRICT_SSL-false}"
VERDACCIO_REGISTRY_SCHEME="http"
printf "//%s/:_authToken=%s\\nregistry=%s\\nstrict-ssl=%s" "$VERDACCIO_REGISTRY_URL" "$NPM_AUTH_TOKEN" "${VERDACCIO_REGISTRY_SCHEME}://$VERDACCIO_REGISTRY_URL" "${VERDACCIO_STRICT_SSL}" > "$VERDACCIO_CONFIG_USERCONFIG"

chmod 0600 "$VERDACCIO_CONFIG_USERCONFIG"

# Start local registry
tmp_registry_log=`mktemp`
sh -c "mkdir -p $HOME/.config/verdaccio"
sh -c "cp --verbose /config.yaml $HOME/.config/verdaccio/config.yaml"
sh -c "nohup verdaccio --config $HOME/.config/verdaccio/config.yaml &>$tmp_registry_log &"
# Wait for `verdaccio` to boot
#
#
# Login so we can publish packages
sh -c "npm set registry https://registry.npmjs.org/"
sh -c "npx npm-auth-to-token@1.0.0 -u test -p test -e test@test.local -r $local_registry"
sh -c "npm whoami --registry $local_registry"
sh -c "lerna publish --npm-client=npm --skip-git --exact --force-publish=* --canary=commit --yes --npm-tag=next --registry $local_registry"