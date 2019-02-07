# We use alpine as the base, and install postgres
FROM alpine:3.5
ENV LANG en_US.UTF-8
ARG PACKAGES="postgresql postgresql-contrib"
ENV PGDATA="/var/lib/postgres/data"

COPY root /

RUN apk --update add --no-cache $PACKAGES && \
    chown -R postgres:postgres /var/lib/postgres

USER postgres

RUN pg_ctl init 
 
EXPOSE 5432/tcp
CMD ["postgres", "-i"]
