#!/bin/bash
#
# Script to deploy a new version.

# 1 required argument: patch, minor, or major
if [[ $# -ne 1 ]] || [[ ! "$1" =~ ^(patch|minor|major)$ ]]; then
  echo "Usage: $0 <patch|minor|major>"
  exit 1
fi

option="$1"

# Get version number
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

# Extract lines from STAGING_NOTES.md starting from line 3
staging_notes=$(tail -n +3 STAGING_NOTES.md)

if [[ -z "$staging_notes" ]]; then
  echo "No staging notes to add. Aborting."
  exit 1
fi

# Insert into CHANGELOG.md two lines after # CHANGELOG
awk -v ver="## ${new_version}" -v notes="$staging_notes" '
BEGIN { inserted = 0 }
{
  print $0
  if (!inserted && /^# CHANGELOG$/) {
    getline; print $0  # blank line after # CHANGELOG
    print ver
    print ""            # blank line after version heading
    print notes
    print ""            # optional: separate from next section
    inserted = 1
  }
}
' CHANGELOG.md > CHANGELOG.tmp && mv CHANGELOG.tmp CHANGELOG.md

# Preserve first two lines of STAGING_NOTES.md
head -n 1 STAGING_NOTES.md > STAGING_NOTES.tmp && mv STAGING_NOTES.tmp STAGING_NOTES.md

echo "Updated version to $new_version"

git add .
git commit -m "release(${option}): ${new_version}"
git push
git tag "v${new_version}"
git push origin "v${new_version}"
dart pub publish
