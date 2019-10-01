#!/bin/sh
# * Explores the $DRONE_COMMIT in $DRONE_REPO and prints the original branch
# * if the commit matches with a merged pull request
payload=$(curl -s "https://api.github.com/search/issues?q=$DRONE_COMMIT&repo:$DRONE_REPO&is:merged")
total_count=$(echo "$payload" | jq -r '.total_count')
if [ $total_count = 1 ]; then
    pull_request_number=$(echo "$payload" | jq -r '.items[0].number')
    pr_payload=$(curl -s "https://api.github.com/repos/$DRONE_REPO/pulls/$pull_request_number")
    merged=$(echo "$pr_payload" | jq -r '.merged')
    if [ $merged = true ]; then
        initial_branch=$(echo "$pr_payload" | jq -r '.head.ref')
        echo "$initial_branch"
    fi
fi
