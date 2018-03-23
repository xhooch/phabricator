#!/bin/sh
if [ -z $SERVICE_HOST ]; then
    echo "SERVICE_HOST not set"
    exit 2
fi

ep /etc/nginx/sites-enabled/*.conf
ep /etc/my_init.d/20_config.sh