#!/bin/zsh
# Checks out various branches and merges updates from main

git pull

for branch in v3-develop develop tua-develop Telco-Preprod-Doc
  do

git checkout $branch
git pull
git merge main
if [ vim ]: then :wq fi
git push

done