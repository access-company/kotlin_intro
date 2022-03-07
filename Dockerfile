FROM node:16-slim

RUN npm init --yes
RUN npm install -g honkit http-server
RUN apt update && apt install make

COPY ./* /workspaces/kotlin_intro

WORKDIR /workspaces
VOLUME /workspaces

ENTRYPOINT ["honkit"]
EXPOSE 8080
