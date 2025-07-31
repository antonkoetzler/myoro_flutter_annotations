# CHANGELOG

## 1.2.3

- fix: Fix error caused when building `copyWith` function with a constructor argument that is not a field

## 1.2.2

- chore: Added some more notes in `README.md`

## 1.2.1

- fix: `buildHashCode` # of fields to use `Object.hash` or `Object.hashAll`

## 1.2.0

- chore: Upgrade dependencies and fix what broke

## 1.1.3

- refactor: Remove extensions and only use mixins

## 1.1.2

- improvement: Make generated extensions and mixins private

## 1.1.1

- Fix deploy script to format when deploying

## 1.1.0

- fix: typedef arguments

## 1.0.10

- Remove `tool/foo.sh`

## 1.0.9

- No changes

## 1.0.8

- feature: Support for type parameters
- feature: Support for abstracted classes

## 1.0.7

- fix: Forgot to remove `example/lib/myoro_app_theme_extension.dart`
- fix: Format files
- feature: Create deployment script

## 1.0.6

- fix: `lib/src/shared/functions/build_copy_with.dart`

## 1.0.5

- fix: `lib/src/shared/functions/build_copy_with.dart` to be able to generate for a class without any fields

## 1.0.4

- fix: `lib/src/shared/functions/build_copy_with.dart`

## 1.0.3

- fix: `.github/workflows/deploy.yml`
- feature: Upgrade `lints` in `pubspec.yaml`

## 1.0.2

- fix: Fix step that was saying "MFL" (Myoro Flutter Library) instead of "MFA" (Myoro Flutter Annotations)
- spike: Prepare project for pub.dev publishing
- chore: Polish documentation
- chore: Polish deployment

## 1.0.1

- fix: Title of `.github/workflows/tests.yml`

## 1.0.0

- Initial version
