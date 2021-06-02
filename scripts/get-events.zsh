#!/bin/zsh
#
# REQUIREMENTS: node, npm (any versions)
#

if [ ! -z "${1}" ]; then
    git clone -b ${1} https://github.com/SAP/spartacus.git temp-cx
else
    git clone https://github.com/SAP/spartacus.git temp-cx
fi

cd ./temp-cx

npm install -D typescript
npm install -D ts-node
npm install -D @types/node
npm install -D ts-morph

ts-node ./scripts/generate-events-doc.ts

cd -

mv ./temp-cx/events.csv events.csv

rm -rf temp-cx


