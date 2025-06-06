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
