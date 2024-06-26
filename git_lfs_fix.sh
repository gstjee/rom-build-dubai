#!/bin/bash

echo "Make sure that you are running this script after repo sync completed !!"

# Scan all folders under current dir
currrent_dir="$(pwd)"
echo "git lfs fix will run for sub directoroes in current dir: $currrent_dir"
folders=$(find $currrent_dir/* -type d)

echo "Installing Git LFS"
git lfs install

# Loop through each folder
for folder in $folders; do
  echo " 
  Processing folder: $folder"
  
  # Check if the folder is a Git repository
  if [ -d "$folder/.git" ]; then
    echo "$folder is a Git repository"
    
    cd "$folder"
    
    # Get the Git directory
    GIT_DIR=$(git rev-parse --git-dir)
    echo "Git directory is: $GIT_DIR"
    
    # Add the folder to the list of safe directories
    echo "Adding $folder to the list of safe directories"
    git config --global --add safe.directory "$folder"
    
    echo "Pulling Git LFS objects"
    git lfs pull
    
    echo "Checking out Git LFS objects"
    git lfs checkout
    
    # Navigate back to the initial directory
    cd - > /dev/null
  else
    echo "$folder is not a Git repository"
  fi
done

echo "
git lfs fix process has been completed"
