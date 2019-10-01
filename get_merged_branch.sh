#!/bin/sh
# echo `git branch --merged master --format "%(refname:strip=2)"`
# current_branch=$(git branch | grep \* | cut -d ' ' -f2)
# current_branch="$DRONE_BRANCH"
# git branch --merged
# git branch -r
# for branch in $(git branch --merged --format "%(refname:strip=2)"); do
#     if [ "$branch" != "$current_branch" ] && [ -z $(git diff "$branch" "$current_branch") ] ; then
#         echo "$branch seems to have been merged"
#     fi
# done
curl "https://api.github.com/search/issues?q=is:merged&repo:$DRONE_REPO&SHA:$DRONE_COMMIT"