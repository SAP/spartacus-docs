#!/bin/zsh
# Checks out various branches and merges updates from the 'main' branch.

git pull

for branch in v3-develop develop tua-develop Telco-Preprod-Doc
  do

git checkout $branch
git pull
git merge main
git push

done

git checkout main