FROM node:23-slim

RUN apt update && apt install make
RUN apt install -y build-essential openjdk-17-jdk graphviz
RUN npm init --yes
RUN npm install -g honkit http-server gitbook-plugin-search-pro-kui gitbook-plugin-uml gitbook-plugin-codeblock-filename gitbook-plugin-head-append

WORKDIR /workspaces
VOLUME /workspaces

#FIXME: Solve below make error, and enable "RUN make"
# 10 0.203 make: *** No targets specified and no makefile found.  Stop.
#RUN make

ENTRYPOINT ["honkit"]
EXPOSE 8080
