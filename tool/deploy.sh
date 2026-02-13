#!/bin/bash
#
# Script to deploy a new version.

# 1 required argument: patch, minor, or major
if [[ $# -ne 1 ]] || [[ ! "$1" =~ ^(patch|minor|major)$ ]]; then
  echo "Usage: $0 <patch|minor|major>"
  exit 1
fi

# Get version number (read-only; validated before any writes)
version_line=$(grep "^version:" pubspec.yaml)
current_version=$(echo "$version_line" | awk '{print $2}')
if [[ -z "$version_line" ]] || [[ ! "$current_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Could not parse version from pubspec.yaml (got: '$current_version'). Aborting."
  exit 1
fi
IFS='.' read -r major minor patch <<< "$current_version"

option="$1"
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

# All checks below must pass before any file writes
echo "Running dart analyze (root)..."
dart analyze . || exit 1
echo "Running dart analyze (example)..."
(cd example && dart analyze .) || exit 1
echo "Running build_runner in example..."
(cd example && dart run build_runner build --delete-conflicting-outputs) || exit 1

# Extract lines from STAGELOG.md starting from line 3
stagelog=$(tail -n +3 STAGELOG.md)

# No notes in STAGELOG.md case
if [[ -z "$stagelog" ]]; then
  echo "No staging notes to add. Aborting."
  exit 1
fi

if [[ ! -f CHANGELOG.md ]] || ! grep -q '^# CHANGELOG$' CHANGELOG.md; then
  echo "CHANGELOG.md missing or missing '# CHANGELOG' heading. Aborting."
  exit 1
fi

# --- Writes below ---

# Set new version being deployed to pubspec.yaml
sed -i.bak "s/^version: .*/version: $new_version/" pubspec.yaml
rm -f pubspec.yaml.bak

# Insert into CHANGELOG.md two lines after # CHANGELOG
awk -v ver="## ${new_version}" -v notes="$stagelog" '
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

# Preserve first two lines of STAGELOG.md
head -n 1 STAGELOG.md > STAGELOG.tmp && mv STAGELOG.tmp STAGELOG.md

# Format code.
bash tool/format_and_fix.sh

# Feedback that the deployment was successful
echo "Updated version to $new_version"

# Push all code and publish to http://pub.dev
git add .
git commit -m "release(${option}): ${new_version}"
git push
git tag "v${new_version}"
git push origin "v${new_version}"
dart pub publish
