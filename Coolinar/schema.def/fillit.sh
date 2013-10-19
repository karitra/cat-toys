#!/bin/env bash
#
LIM=128

pushd `pwd`

sqlite3 coolinar.db < coolinar.sql

for i in $(seq 1 $LIM); do
    sqlite3 coolinar.db "insert into recipes(name, desc) values('name_$i', 'Some long desc: desc_$((i*100))' )"
done

popd
