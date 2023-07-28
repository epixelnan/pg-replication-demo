FROM postgres:14

COPY ./entrypoint.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT /entrypoint.sh
