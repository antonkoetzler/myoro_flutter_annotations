# Deploying

1. Whenever you are commit to main, the commit must have this template: `release(major/minor/patch): <Description>`

- `<Description>` must always be what is after the colon of said version in `CHANGELOG.md`
- Examples: `release(patch): Preparing to publish to pub.dev`, `release(major): Version 2!`

2. After pushing with the templated commit message, deployment will start on GitHub

- New version tag will be created
- `pubspec.yaml`'s version will be automatically updated

3. After `.github/workflows/deploy.yml` passes, run `dart pub publish` to update <https://pub.dev>
