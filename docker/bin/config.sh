#!/bin/sh

cd /var/www/phabricator/phabricator/bin
./config set mysql.host ${SQL_HOST}
./config set mysql.user ${SQL_USER}
./config set mysql.pass ${SQL_PASS}
./storage upgrade --user ${SQL_USER} --password ${SQL_PASS}

./config set load-libraries '{"sprint":"${SPRINT_PLUGIN_PATH}"}'