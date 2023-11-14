#!/bin/bash

cat <<EOT >> /etc/clickhouse-server/config.d/postgres.xml
<clickhouse>
    <postgresql_port>9005</postgresql_port>
</clickhouse>
EOT

# Call clickhouse docker entrypoint to setup everything.
su clickhouse -c 'CLICKHOUSE_DB=clickhouse CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1 CLICKHOUSE_PASSWORD=password /entrypoint.sh --daemon'
