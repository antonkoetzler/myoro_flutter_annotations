# Deploying

1. Run the command: `bash tool/deploy.sh <patch/minor/major>`. This will

- Push the code to main
- Creates a tag for the version
- Moves the contents of `STAGING_NOTES.md` to `CHANGELOG.md`
