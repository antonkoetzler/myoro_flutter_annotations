# Deploying

1. Update the version of `pubspec.yaml`

- Patch: `1.0.0` --> `1.0.1`
- Minor: `1.0.11` --> `1.1.0`
- Major: `1.2.3` --> `2.0.0`

2. Create a commit message with this template: `release: <Version number>` where the version number is from `pubspec.yaml`

- The only altered file in this commit should be `pubspec.yaml`; nothing else
- Example: `release: 2.0.0`

3. Create a tag named `v<Version number>`, i.e. `v2.0.0`

- Command: `git tag v2.0.0; git push origin v2.0.0`

4. Run `dart pub publish` to update <https://pub.dev/packages/myoro_flutter_annotations>

- Check if it updated around 10 minutes after running the command
