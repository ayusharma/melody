FROM node:latest

LABEL version="1.0.0"
LABEL repository="https://github.com/trivago/melody"
LABEL homepage="https://github.com/trivago/melody/"
LABEL "maintainer"="trivago <ayush.sharma@trivago.com>"

LABEL com.github.actions.name="GitHub Action for NVM"
LABEL com.github.actions.description="Wraps the NVM CLI to enable common NVM commands."


# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION latest

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

RUN source $NVM_DIR/nvm.sh

# confirm installation
RUN nvm -v

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]