FROM postgres:9.5.7-alpine

RUN apk add --no-cache openssl curl py-pip postgresql-dev make gcc musl-dev && \
    pip install pgxnclient && \
    pgxnclient install temporal_tables

