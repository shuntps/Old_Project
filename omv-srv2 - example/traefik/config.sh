#!/bin/bash

### Variable
# DOCKERDIR=
# GITDIR=
# CI_PROJECT_NAME=
# USERS=
ACME=$DOCKERDIR/traefik/acme/acme.json
ACME_TMP=/tmp/acme.json
LOGS=$DOCKERDIR/traefik/logs/traefik.log

### Cleanup
if [ -f "$ACME" ]; then
    echo "$ACME exists, backup"
    mv -f $ACME /tmp
else 
    echo "$ACME does not exist, keep on going"
fi
rm -rf \
    $DOCKERDIR/traefik

### Make folders
mkdir -p \
	$DOCKERDIR/traefik{/acme,/logs,/rules}

### Copy over any rules files to rules folder
[[ -e $GITDIR/$CI_PROJECT_NAME/traefik/rules ]] && \
    cp -R $GITDIR/$CI_PROJECT_NAME/traefik/rules/ $DOCKERDIR/traefik/

### Make files
if [ -f "$ACME_TMP" ]; then
    echo "$ACME_TMP exists, restore"
    touch \
        $LOGS
    mv -f \
        $ACME_TMP $ACME
else
    echo "$ACME_TMP does not exist, keep on going"
    touch \
        $LOGS $ACME
fi

### Permissions
chown -R $USERS:users \
    $DOCKERDIR/traefik

chmod 600 $ACME