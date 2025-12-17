# Myoro Flutter Annotations (MFA)

Is boilerplate starting to get super annoying to write by hand? Do you want basic practical functions like `copyWith` in your classes done for you? How about automatic equality overrides? Myoro Flutter Annotations (MFA) is what you are looking for.

## Features

1. Ability to create generated code for models with `@myoroModel` and `ThemeExtension`s with `@myoroThemeExtension`
2. Creates a `mixin` that implements the following functions for both models and `ThemeExtension`s:

- `copyWith` with the functionality to be able to set nullable fields to null
- `==` operator and `hashCode` to be able to compare to classes
- `toString` for better debugging

## Want to see the generated code?

Check `example/lib` to see the generated code that MFA produces.

## Documentation

All documentation is stored on this [Notion website](https://tough-shoemaker-cbd.notion.site/Myoro-Flutter-Annotations-2b5d7dcd55248067a842c041a0182fcb?pvs=74).
