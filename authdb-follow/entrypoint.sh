#!/bin/bash

if [ -z "$MASTER_HOST" ]; then
	echo 'replication follower error: $MASTER_HOST not set.'
	exit 1
fi

# TODO FIXME systematic retry instead
# wait for the leader
sleep 1

chown -R postgres:postgres /var/lib/postgresql/data/
chmod -R 0700 /var/lib/postgresql/data/

echo 'local all all trust' > /var/lib/postgresql/pg_hba.conf
echo 'host all all all md5' >> /var/lib/postgresql/pg_hba.conf

# /var/lib/postgresql/ seems to be the home
# XXX replication is a keyword, not the verbatim db name
echo "$MASTER_HOST:*:replication:replicator:$PGPOOL_SR_CHECK_PASSWORD" > /var/lib/postgresql/.pgpass
chown postgres:postgres /var/lib/postgresql/.pgpass
chmod 0600 /var/lib/postgresql/.pgpass

# pg_basebackup may fail if the db is already init'd. So start postgres anyway.
# NOTE: setting PGPASSFILE is redundant
su postgres - bash -c "PGPASSFILE=/var/lib/postgresql/.pgpass pg_basebackup -h "$MASTER_HOST" -U replicator -D $PGDATA -Xs -R; postgres"
