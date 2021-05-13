#!/bin/zsh
# Checks out various branches and merges updates from the 'main' branch.

git pull

for branch in develop tua-develop fsa Telco-Preprod-Doc v3.4-develop
  do

git checkout $branch
git pull
git merge main
git push

done

git checkout main