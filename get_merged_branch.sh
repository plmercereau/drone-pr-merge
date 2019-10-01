#!/bin/sh
# * Explores the $DRONE_COMMIT in $DRONE_REPO and prints the original branch
# * if the commit matches with a merged pull request
payload=$(curl -s "https://api.github.com/search/issues?q=$DRONE_COMMIT&repo:$DRONE_REPO&is:merged")
if [ $(echo "$payload" | jq -r '.total_count') = 1 ]; then
    pull_request_number=$(echo "$payload" | jq -r '.items[0].number')
    pr_payload=$(curl -s "https://api.github.com/repos/$DRONE_REPO/pulls/$pull_request_number")
    if [ $(echo "$pr_payload" | jq -r '.merged') = true ]; then
        echo "$pr_payload" | jq -r '.head.ref'
    fi
fi
