#!/bin/sh

DIR=/etc/traefik
ACME=$DIR/acme/acme.json
LOGS=$DIR/logs/traefik.log
USERS=shunt
GROUP=shunt
PUID=1000

### Make folders
mkdir -p \
    $DIR/acme \
    $DIR/logs \
    $DIR/rules

### Make files
if [ ! -f "$ACME" ]; then
    touch \
        $ACME
fi

if [ ! -f "$LOGS" ]; then
    touch \
        $LOGS
fi

### Copy over any rules files to rules folder
[[ -e /defaults/rules ]] && \
    cp -R /defaults/rules/ $DIR/

### Permissions
addgroup $USERS && \
adduser -H -D -u $PUID $USERS -G $GROUP

chown -R $USERS:$GROUP $DIR

chown root:root $ACME && \
chmod 600 $ACME

### Cleanup
rm -rf defaults

exec "$@"