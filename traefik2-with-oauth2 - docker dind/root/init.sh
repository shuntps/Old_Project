#!/bin/sh

ACME=/etc/traefik/acme/acme.json
LOGS=/etc/traefik/logs/traefik.log

### Make folders
mkdir -p \
    /etc/traefik/acme \
    /etc/traefik/logs \
    /etc/traefik/rules

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
    cp -R /defaults/rules/ /etc/traefik/

### Permissions
adduser -H -D -u 1000 shunt -G users

chown -R shunt:users \
	/etc/traefik

chmod 600 /etc/traefik/acme/acme.json

### Cleanup
rm -rf \
    defaults

exec "$@"