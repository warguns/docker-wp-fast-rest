#!/bin/bash

/usr/local/bin/docker-entrypoint.sh apache2-noope

if [ ! -f .rest-created ]; then
    wp --allow-root core install --url="${REST_URL}" --title="${REST_TITLE}" --admin_user="${REST_ADMIN_USER}" --admin_password="${REST_ADMIN_PASS}" --admin_email="${REST_EMAIL}"
    wp --allow-root plugin install $(cat /tmp/plugins) --activate
    touch .rest-created
fi

exec "$@"