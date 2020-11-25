FROM strapi/base:14-alpine

EXPOSE 1337

ENV NODE_ENV ${NODE_ENV}

RUN apk add --no-cache tini rsync

WORKDIR /srv/app
RUN chown -R 1000:1000 .

COPY ./package*.json ./

USER 1000

RUN npm install && npm cache clean --force

COPY --chown=1000:1000 . .

RUN chmod a+x /srv/app/run.sh

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/srv/app/run.sh"]