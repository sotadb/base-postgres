# We use alpine as the base, and install postgres
FROM alpine:3.5
ENV LANG en_US.UTF-8
ARG PACKAGES="postgresql postgresql-contrib"
ENV PGDATA="/var/lib/postgres/data"

RUN apk --update add --no-cache $PACKAGES && \
    mkdir -p /var/lib/postgres/data && \
    chown -R postgres:root /var/lib/postgres && \
    chmod -R 0700 /var/lib/postgres

USER postgres
RUN pg_ctl init 
COPY --chown=postgres:root root /
 
EXPOSE 5432/tcp
CMD ["postgres", "-i"]
