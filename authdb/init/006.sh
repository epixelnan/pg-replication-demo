psql -U "$POSTGRES_USER" -d "$POSTGRES_NAME" -c "CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD '$PGPOOL_SR_CHECK_PASSWORD';"
