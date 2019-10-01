## Handling Pull Request mergers with Drone.io CI/CD and the GitHub API

This is a very small example of a workaround to allow Drone.io to handle PR merge events.
This repo is rather a proof of concept, but contributions are welcome to make it more effective, while waiting for the Drone team to implement some kind of a 'pull_request_merge' event.

The `get_merged_branch.sh` script reaches the GitHub API to get the right information from the GitHub API, and prints the orginial branch of the PR.

This script can be then called in a Drone pipeline (or any similar CI/CD platform). In the `.drone.yml` of this repo, the output is stored in an environment variable: `export MERGED_FROM_BRANCH=$(./get_merged_branch.sh)`. If the output is empty, then the ongoing step stops with `'[[ -z $MERGED_FROM_BRANCH ]] && exit'`.

Please note that the script requires `jq` and `curl` (not installed in Alpine by default).
