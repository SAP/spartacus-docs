#!/bin/zsh
# Checks out various branches and merges updates from the 'main' branch.

git pull

for branch in develop develop-6.0 tua-develop fsa
  do

git checkout $branch
git pull
git merge main
git push

done

git checkout main