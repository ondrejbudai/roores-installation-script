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

rm -rf WWW/IIS roores notorm

pushd roores-install-dir

if [ $# -eq 1 ]; then
    git checkout $1
fi

pushd install
./new_db.sh
popd

popd

mkdir -p WWW
mv roores-install-dir/WWW WWW/IIS
mv roores-install-dir/roores .
mv roores-install-dir/notorm .

rm -rf roores-install-dir

echo 'AddHandler application/x-httpd-php70 .php' >WWW/IIS/.htaccess
chmod -R g=,o=rx WWW
sed "s#define('PATH_TO_ROORES', '/../roores')#define('PATH_TO_ROORES', '/../../roores')#" WWW/IIS/index.php > WWW/IIS/index.php.new
mv WWW/IIS/index.php.new WWW/IIS/index.php
