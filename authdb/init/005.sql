-- ref: https://www.percona.com/blog/2018/09/07/setting-up-streaming-replication-postgresql/

ALTER SYSTEM SET hba_file='/var/lib/postgresql/pg_hba.conf';

-- Mapped to 'replica' in pg v9.6+
ALTER SYSTEM SET wal_level='hot_standby';

ALTER SYSTEM SET archive_mode=on;

-- TODO after testing: 1 + 2*no_of_followers
ALTER SYSTEM SET max_wal_senders=10;

--Instead of obsolete `wal_keep_segments=100` (16000 = 100 * 16MB);
ALTER SYSTEM SET wal_keep_size=16000;

-- TODO modify?
ALTER SYSTEM SET listen_addresses='*';

ALTER SYSTEM SET hot_standby=on;

ALTER SYSTEM SET archive_command='test ! -f /var/lib/postgresql/archive/%f && cp %p /var/lib/postgresql/archive/%f';

SELECT pg_reload_conf();
