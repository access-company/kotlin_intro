#!/bin/bash -e

# collect commit messages until last "update site" to HEAD
echo "update site"
git log --reverse $(git log --grep="update site" -n 1 --pretty=format:%h)..HEAD --pretty=format:"* %b" --merges | grep ^*
