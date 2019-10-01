#!/bin/sh
payload=$(curl -s "https://api.github.com/search/issues?q=$DRONE_COMMIT&repo:$DRONE_REPO&is:merged")
total_count=$(echo "$payload" | jq -r '.total_count')
if [ $total_count = 1 ]; then
    pull_request_number=$(echo "$payload" | jq -r '.items[0].number')
    pr_payload=$(curl -s "https://api.github.com/repos/$DRONE_REPO/pulls/$pull_request_number")
    initial_branch=$( echo "$pr_payload" | jq -r '.head.ref')
    echo "$initial_branch"
else
  echo "try again"
fi
