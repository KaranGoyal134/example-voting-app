#!/bin/bash

set -e

# Set the repository URL
REPO_URL="https://${PAT_TOKEN}@dev.azure.com/karangoyal969/My-Voting-app/_git/My-Voting-app"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

git config user.email "azure-pipeline@dev.azure.com"
git config user.name "Azure Pipeline"

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s|image:.*|image: $2/$1:$3|g" k8s-specifications/$1-deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo
