# We use alpine as the base, and install postgres
FROM alpine:3.9
ENV LANG en_US.UTF-8
ARG PACKAGES="postgresql postgresql-contrib"
ENV PGDATA="/var/lib/postgres/data"

RUN apk --update add --no-cache $PACKAGES && \
    apk --update add --no-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
      postgis && \
    mkdir -p /var/lib/postgres/data && \
    mkdir -p /var/lib/postgres/ssl && \
    chown -R postgres:root /var/lib/postgres

USER postgres
RUN pg_ctl init
COPY --chown=postgres:root postgresql.conf /var/lib/postgres/data/
COPY --chown=postgres:root pg_hba.conf /var/lib/postgres/data/

EXPOSE 5432/tcp
CMD ["postgres", "-i"]
