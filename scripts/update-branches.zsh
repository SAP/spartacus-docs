#!/bin/zsh
# Checks out various branches and merges updates from main

git pull

for branch in v3-develop develop tua-develop Telco-Preprod-Doc
  do

checkout $branch
git pull
git merge main
:wq
git push

done