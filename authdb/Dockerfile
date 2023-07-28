FROM postgres:14

RUN mkdir -p /var/lib/postgresql/archive
# 999 is postgres for the postgres Docker image
#chown postgres:postgres /var/lib/postgresql/archive
RUN chown 999:999 /var/lib/postgresql/archive
RUN chmod 0700 /var/lib/postgresql/archive
