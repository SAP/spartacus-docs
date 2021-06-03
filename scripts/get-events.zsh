#!/bin/zsh
#
# REQUIREMENTS: node, npm (any versions)
#

if [ ! -z "${1}" ]; then
    echo "Cloning Spartacus repo on branch ${1}"
    git clone -b ${1} https://github.com/SAP/spartacus.git temp-cx
else
    echo "Cloning Spartacus develop branch"
    git clone https://github.com/SAP/spartacus.git temp-cx
fi

echo "Copying script to cloned repo"
cp ./scripts/generate-events-doc.ts ./temp-cx/scripts/

cd ./temp-cx

echo "Installing dependencies"
npm install -D typescript
npm install -D ts-node
npm install -D @types/node
npm install -D ts-morph

echo "Generating events CSV"
ts-node ./scripts/generate-events-doc.ts

cd -

echo "Moving CSV to _data/"
mv ./temp-cx/events.csv ./_data/events.csv

echo "Deleting temp-cx"
rm -rf temp-cx


