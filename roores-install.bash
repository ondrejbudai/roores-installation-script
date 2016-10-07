#!/usr/bin/env bash


git clone git@github.com:ondrejbudai/roores.git roores-install-dir 2>/dev/null
STATUS=$?

if [ $STATUS -ne 0 ]; then
    git clone https://github.com/ondrejbudai/roores.git roores-install-dir 2>/dev/null
    STATUS=$?

    if [ $STATUS -ne 0 ]; then
        echo 'Git clone failed!' 2>/dev/null
        exit 1
    fi
fi

rm -rf WWW roores

pushd roores-install-dir

if [ $# -eq 1 ]; then
    git checkout $1
fi

popd

mv roores-install-dir/WWW .
mv roores-install-dir/roores .

rm -rf roores-install-dir

chmod g=,o=rx WWW
