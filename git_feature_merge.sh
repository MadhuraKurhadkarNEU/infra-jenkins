#!/bin/bash

# Check if commit message is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <commit-message>"
  exit 1
fi

# Assign the commit message to a variable
COMMIT_MESSAGE="$1"

# Create and switch to the new branch 'feature1'
git checkout -b feature1

# Add all changes to the staging area
git add .

# Commit changes with the provided commit message
git commit -m "$COMMIT_MESSAGE"

# Push the new branch to the origin
git push origin feature1

# Prompt user to compare and create a pull request via UI
echo "Please compare and create a pull request for the 'feature1' branch on GitHub."
echo "Press any key to continue after the pull request has been merged..."
read -n 1 -s

# Switch to the main branch
git checkout main

# Pull the latest changes from the upstream main branch
git pull upstream main

# Merge the 'feature1' branch into the 'main' branch
git merge feature1

# Push the updated main branch to the origin
git push origin main

echo "Workflow completed successfully."
