FROM ubuntu:18
USER root
RUN apt-get update
RUN apt-get -y install curl gnupg=
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get -y install nodejs
RUN apt-get install nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN service nginx reload

WORKDIR /home/app

COPY ./package-lock.json /home/app/package-lock.json
COPY ./package.json /home/app/package.json

RUN npm install

COPY ./src /home/app/src
COPY ./bot.json /home/app/bot.json

EXPOSE 1337

CMD ["npm", "run", "app"]
