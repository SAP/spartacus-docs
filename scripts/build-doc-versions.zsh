#!/bin/zsh
# Builds current committed main branch from GitHub to a local destination, then pushes udpates to main (origin). 
# Run with the version number as a parameter. You can input multiple version numbers, as follows: 
# for v in 1.x 2.x 3.x

# Variables
installed="bundle"
for v in 1.x 2.x
  do

# Get the latest commit SHA in sourcedir branch
last_SHA=( $(git rev-parse --short HEAD) )
# The name of the temporary folder will be the
#   last commit SHA, to prevent possible conflicts
#   with other folder names.
clone_dir="/tmp/$v-clone_$last_SHA/"
echo $last_SHA

# Make sure Jekyll is installed locally
if ! gem list $installed; then
        echo "You do not have the pre-reqs installed. Refer to the README for
requirements."
        exit 0
fi

# Create directory to hold temporary clone
mkdir $clone_dir
cd $clone_dir
git clone git@github.com:SAP/spartacus-docs.git
cd spartacus-docs
build_dir="/tmp/$v-build_$last_SHA"
echo $build_dir

echo "Checking out $v branch"
git checkout version/$v

# Create a configuration file that sets a new baseurl based on version
echo "baseurl : /spartacus-docs/$v" > _config.$v.yml

bundle install
bundle exec jekyll build --config _config.yml,_config.$v.yml -d $build_dir/spartacus-docs/$v

if [ $? = 0 ]; then
  echo "Jekyll build successful for " $v
else
   echo "Jekyll build failed for " $v
#    exit 1
fi

echo "Copying data, includes and layouts folders to the build directory"
cp -R $clone_dir/spartacus-docs/_data $clone_dir/spartacus-docs/_includes $clone_dir/spartacus-docs/_layouts $build_dir/spartacus-docs/$v

# Check out main branch
echo "Checking out main branch"
git checkout main

echo "Deleting target $v folder"
rm -r  /Users/i839916/spartacus-docs/$v

echo "Copying all build files to new $v folder in spartacus-docs"
cp -R $build_dir/spartacus-docs/$v  /Users/i839916/spartacus-docs

cd  /Users/i839916/spartacus-docs

# Provides a publishing date stamp
publishdate=`date +%m-%d-%Y`
echo $publishdate
echo $last_SHA

echo "Staging all files in $v folder"
git add $v

echo "Committing all updated files"
git commit -a -m "Publishing $v to GitHub Pages on $publishdate with $last_SHA"

echo "Files committed, pushing to main (publishing to GitHub Pages)"
git push origin main

done
