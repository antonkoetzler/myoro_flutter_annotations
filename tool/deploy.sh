#!/bin/bash
#
# Script to deploy a new version.

# 1 required argument: patch, minor, or major
if [[ $# -ne 1 ]] || [[ ! "$1" =~ ^(patch|minor|major)$ ]]; then
  echo "Usage: $0 <patch|minor|major>"
  exit 1
fi

option="$1"

version_line=$(grep "^version:" pubspec.yaml)
current_version=$(echo "$version_line" | awk '{print $2}')
IFS='.' read -r major minor patch <<< "$current_version"

case "$option" in
  patch)
    patch=$((patch + 1))
    ;;
  minor)
    minor=$((minor + 1))
    patch=0
    ;;
  major)
    major=$((major + 1))
    minor=0
    patch=0
    ;;
esac

new_version="${major}.${minor}.${patch}"

sed -i.bak "s/^version: .*/version: $new_version/" pubspec.yaml
rm pubspec.yaml.bak

echo "Updated version to $new_version"

git add .
git commit -m "release(${option}): ${new_version}"
git push
git tag "v${new_version}"
git push origin "v${new_version}"
dart pub publish
