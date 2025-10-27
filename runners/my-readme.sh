# 13-October-2025
# RESULTS:  
#    INITIAL ERRORS: 
#    Libicu's dependencies is missing for Dotnet Core 6.0
#    Execute sudo ./bin/installdependencies.sh to install any missing Dotnet Core 6.0 dependencies.

    # SOLVED WITH: apt update; apt-get install -y libicu-dev

# See what architecture the current machine has
docker info | grep Architecture 
-> Architecture: aarch64

# Create a new self-hosted runner
https://github.com/pietronromano/github-actions-runners/settings/actions/runners/new


# Start a ​console in the latest version of an​ Ubuntu container, start the bash shell: 
docker run -it --platform linux/x86_64 --name cnt-github-runner ubuntu:latest /bin/bash

# To download the runner binaries, we have to install curl in the container as this is not part of the normal Ubuntu image
apt-get -y update; apt-get -y install curl

# Download
# Create a folder
mkdir actions-runner && cd actions-runner

# Download the latest runner package
curl -o actions-runner-linux-x64-2.328.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz

# Optional: Validate the hash
echo "01066fad3a2893e63e6ca880ae3a1fad5bf9329d60e77ee15f2b97c148c3cd4e  actions-runner-linux-x64-2.328.0.tar.gz" | shasum -a 256 -c

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.328.0.tar.gz

# Install ​the dependencies that are needed for the runner by executing the following script: 
apt-get install -y sudo
sudo ./bin/installdependencies.sh

# Before we​ can configure the runner, we have to allow it to run as root as our container runs as root per default. 
# We can do this by setting the RUNNER_ALLOW_RUNASROOT environment variable to a non-zero value: 
export RUNNER_ALLOW_RUNASROOT="1"

# MINE!!: Avoid missing libicu needed for dotnet 6
apt update; apt-get install -y libicu-dev

# Configure
# Create the runner and start the configuration experience

./config.sh --url https://github.com/pietronromano/github-actions-runners --token AFBBT6TW3AUVY3AL47SHEO3I5UUP4

# Last step, run it!
./run.sh

# Using your self-hosted runner
# Use this YAML in your workflow file for each job
runs-on: self-hosted

################################################

##########################################################
# Get a configuration token: Cookbook: (p. 191).
$ curl -L \
-X POST \
-H "Accept: application/vnd.github+json" \
-H "Authorization: Bearer <YOUR-PAT>" \
-H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/repos/{OWNER}/{REPO}/actions/runners/registration-token 

# The result also contains the expiration date. 
# If you want to use the token in a variable, pipe the result to jq, like this: 
TOKEN=$(<curl command> | jq .token --raw-output)




