#!/bin/bash

set -e
sh-c "wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash"
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
sh -c "nvm $*"