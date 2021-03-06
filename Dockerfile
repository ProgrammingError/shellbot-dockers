#inherit debian node docker
FROM node:current-buster

#locales ref:- https://hub.docker.com/_/debian
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

#add non-free repo
RUN apt update -y && apt install software-properties-common -y && apt update -y && apt upgrade -y
RUN apt-add-repository non-free && \
    apt-get -qq update

#update repositories and upgrade dependencies
RUN apt install -y bash git neofetch make python build-essential nodejs npm sudo

RUN git clone https://github.com/botgram/shell-bot.git
RUN cd shell-bot
#copy the entire source

#install nodejs dependencies
RUN npm install -g npm@7.1.1
RUN npm install

#run
CMD ["node","server"]
