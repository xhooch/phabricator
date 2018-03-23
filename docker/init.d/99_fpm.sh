#!/bin/sh
rm -f /etc/php/7.1/fpm/env.conf
for var in $(ls /etc/container_environment); do
    echo "env[$var]=\$$var" >> /etc/php/7.1/fpm/env.conf;
done
