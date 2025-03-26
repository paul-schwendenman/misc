#!/bin/bash

# Usage: ./clone_local_repos.sh <source_dir> <target_dir>

SOURCE_DIR="$1"
TARGET_DIR="$2"

if [[ -z "$SOURCE_DIR" || -z "$TARGET_DIR" ]]; then
  echo "Usage: $0 <source_dir> <target_dir>"
  exit 1
fi

mkdir -p "$TARGET_DIR"

FAILED_REPOS=()

for repo_path in "$SOURCE_DIR"/*; do
  if [ -d "$repo_path/.git" ]; then
    repo_name=$(basename "$repo_path")
    target_repo="$TARGET_DIR/$repo_name"

    if [ -d "$target_repo/.git" ]; then
      echo "⚠️  Skipping $repo_name (already exists)"
      continue
    fi

    echo "Cloning $repo_name..."

    tmp_bare=$(mktemp -d)

    if git --git-dir="$repo_path/.git" clone --mirror "$repo_path" "$tmp_bare" 2>/dev/null; then
      if git clone "$tmp_bare" "$target_repo" 2>/dev/null; then
        cd "$target_repo" || continue
        git remote rename origin local

        cd "$repo_path"
        for remote in $(git remote); do
          if [ "$remote" != "origin" ]; then
            url=$(git remote get-url "$remote")
            cd "$target_repo"
            git remote add "$remote" "$url"
          fi
        done

        cd "$target_repo"
        git fetch --all --tags
        echo "✅ Finished cloning $repo_name"
      else
        echo "❌ Failed to clone $repo_name from bare mirror"
        FAILED_REPOS+=("$repo_name")
      fi
    else
      echo "❌ Failed to create bare mirror for $repo_name"
      FAILED_REPOS+=("$repo_name")
    fi

    rm -rf "$tmp_bare"
    echo
  fi
done

# Summary
if [ ${#FAILED_REPOS[@]} -ne 0 ]; then
  echo "🚨 The following repos failed to clone:"
  for repo in "${FAILED_REPOS[@]}"; do
    echo "  - $repo"
  done
else
  echo "🎉 All repositories cloned successfully!"
fi
