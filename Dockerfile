FROM node:8-alpine

RUN apk --update add --virtual build-dependencies git \
    && git clone https://github.com/priologic/easyrtc.git /usr/src/easyrtc \
    && cd /usr/src/easyrtc \
    && npm install \
    && apk del build-dependencies

WORKDIR /usr/src/app

COPY package*.json .
COPY server.js .

RUN mkdir -p static
RUN echo "" >> static/index.html
RUN npm install --production
ENV NODE_ENV production

EXPOSE 8080
CMD ["node", "server.js"]