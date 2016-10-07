#!/usr/bin/env bash

rm -rf WWW roores

git clone git@github.com:ondrejbudai/roores.git roores-install-dir
pushd roores-install-dir

if [ $# -eq 1 ]; then
    git checkout $1
fi

popd

mv roores-install-dir/WWW .
mv roores-install-dir/roores .

rm -rf roores-install-dir

chmod g=,o=rx WWW
