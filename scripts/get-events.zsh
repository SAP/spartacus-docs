#!/bin/zsh
#
# REQUIREMENTS: node, npm (any versions)
#
# To run the script against a particular release, just add the release tag name when running the script
#
# For example: scripts/get-events.zsh 2211.28.0
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
npm install --dev typescript
npm install --dev ts-node
npm install --dev @types/node
npm install --dev ts-morph

echo "Generating events CSV"
npx ts-node ./scripts/generate-events-doc.ts

cd -

echo "Moving CSV to _data/"
mv ./temp-cx/events.csv ./_data/events.csv

echo "Deleting temp-cx"
rm -rf temp-cx


