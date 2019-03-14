FROM node:11

LABEL version="1.0.0"
LABEL repository="https://github.com/trivago/melody"
LABEL homepage="https://github.com/trivago/melody/"
LABEL "maintainer"=" trivago <ayush.sharma@trivago.com>"

LABEL com.github.actions.name="GitHub Action for Yarn"
LABEL com.github.actions.description="Wraps the yarn CLI to enable common yarn commands."
LABEL com.github.actions.icon="package"

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]