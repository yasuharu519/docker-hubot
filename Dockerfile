FROM ubuntu

MAINTAINER yasuharu519 <yasuharu519@gmail.com>

RUN apt-get update
RUN apt-get -y install expect nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

RUN useradd -d /hubot -m -s /bin/bash -U hubot

USER hubot
WORKDIR /hubot

RUN yo hubot --owner=${HUBOT_OWNER} --name=${HUBOT_NAME} --description=${HUBOT_DESCRIPTION} --defaults

ADD hubot-scripts.json /hubot/hubot-scripts.json
ADD scripts /hubot/scripts

RUN npm install hubot-slack --save && npm install

CMD bin/hubot -a slack
