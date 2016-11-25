#!/usr/bin/env bash


git clone --recursive git@github.com:ondrejbudai/roores.git roores-install-dir 2>/dev/null
STATUS=$?

if [ $STATUS -ne 0 ]; then
    git clone --recursive https://github.com/ondrejbudai/roores.git roores-install-dir 2>/dev/null
    STATUS=$?

    if [ $STATUS -ne 0 ]; then
        echo 'Git clone failed!' 2>/dev/null
        exit 1
    fi
fi

rm -rf WWW roores notorm

pushd roores-install-dir

if [ $# -eq 1 ]; then
    git checkout $1
fi

popd


php roores-install-dir/install/db_drop_tables.php
php roores-install-dir/install/db_init_tables.php
php roores-install-dir/install/db_init_values.php

mv roores-install-dir/WWW .
mv roores-install-dir/roores .
mv roores-install-dir/notorm .

rm -rf roores-install-dir

echo 'AddHandler application/x-httpd-php70 .php' >WWW/.htaccess
chmod -R g=,o=rx WWW
