FROM node:16-slim

RUN apt update && apt install make
RUN apt install -y build-essential openjdk-11-jre graphviz
RUN npm init --yes
RUN npm install -g honkit http-server gitbook-plugin-search-pro-kui gitbook-plugin-uml gitbook-plugin-codeblock-filename

WORKDIR /workspaces
VOLUME /workspaces

#RUN make

ENTRYPOINT ["honkit"]
EXPOSE 8080
