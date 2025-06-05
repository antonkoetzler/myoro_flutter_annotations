# Deploying

1. Whenever you are commit to main, the commit must have this template: `release(major/minor/patch): <Description>`

- `<Description>` must always be what is after the colon of said version in `CHANGELOG.md`
- Examples: `release(patch): Preparing to publish to pub.dev`, `release(major): Version 2!`

2. After pushing with the templated commit message, deployment should be 100% automatic because of `.github/workflows/deploy.yml`
