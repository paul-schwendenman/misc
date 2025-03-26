#!/bin/bash

# Usage: ./clone_local_repos.sh <source_dir> <target_dir>
# Example:
# ./clone_local_repos.sh /media/paul/.../projects ~/projects

set -e

SOURCE_DIR="$1"
TARGET_DIR="$2"

if [[ -z "$SOURCE_DIR" || -z "$TARGET_DIR" ]]; then
  echo "Usage: $0 <source_dir> <target_dir>"
  exit 1
fi

mkdir -p "$TARGET_DIR"

for repo_path in "$SOURCE_DIR"/*; do
  if [ -d "$repo_path/.git" ]; then
    repo_name=$(basename "$repo_path")
    target_repo="$TARGET_DIR/$repo_name"

    echo "Cloning $repo_name..."

    # Clone the repo as a bare repo into a temp directory to preserve everything
    tmp_bare=$(mktemp -d)
    git --git-dir="$repo_path/.git" clone --mirror "$repo_path" "$tmp_bare"

    # Clone from the bare into the target dir
    git clone "$tmp_bare" "$target_repo"

    cd "$target_repo"

    # Rename 'origin' to 'local'
    git remote rename origin local

    # Re-add any other remotes from the original repo
    cd "$repo_path"
    for remote in $(git remote); do
      if [ "$remote" != "origin" ]; then
        url=$(git remote get-url "$remote")
        cd "$target_repo"
        git remote add "$remote" "$url"
      fi
    done

    cd "$target_repo"
    echo "Fetching all branches and tags..."
    git fetch --all --tags

    # Clean up temp bare repo
    rm -rf "$tmp_bare"

    echo "✅ Finished cloning $repo_name"
    echo
  fi
done

echo "🎉 All repositories cloned to $TARGET_DIR"
