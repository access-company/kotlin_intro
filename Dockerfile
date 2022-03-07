FROM node:16-slim

RUN npm init --yes
RUN npm install -g honkit
RUN apt update

COPY ./* /workspaces/kotlin_intro

WORKDIR /workspaces
VOLUME /workspaces

ENTRYPOINT ["honkit"]
