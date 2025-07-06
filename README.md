# Myoro Flutter Annotations (MFA)

Is boilerplate starting to get super annoying to write by hand? Do you want basic practical functions like `copyWith` in your classes done for you? How about automatic equality overrides? Myoro Flutter Annotations (MFA) is what you are looking for.

## Features

1. Ability to create generated code for models with `@myoroModel` and `ThemeExtension`s with `@myoroThemeExtension`
2. Creates a `mixin` that implements the following functions for both models and `ThemeExtension`s:

- `copyWith` with the functionality to be able to set nullable fields to null
- `==` operator and `hashCode` to be able to compare to classes
- `toString` for better debugging

## Documentation Table of Contents

1. [`Deploying.md`](https://github.com/antonkoetzler/myoro_flutter_annotations/blob/main/doc/Deploying.md)
2. [`Standards.md`](https://github.com/antonkoetzler/myoro_flutter_annotations/blob/main/doc/Standards.md)

## Want to see the generated code?

Check `example/lib` to see the generated code that MFA produces.
