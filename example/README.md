# Example

## Usage

### `@myoroModel`

```dart
part 'test_model.g.dart';

@immutable
@myoroModel
final class FooModel with _$FooModelMixin {
  ...
}
```

1. Add the generated file as a `part` directive;
2. Add the `@immutable` annotation. Doesn't effect code generation, but models **should** be immutable by nature, so add it;
3. Add the `@myoroModel` annotation;
4. Attach the generated `mixin`.

### `@myoroThemeExtension`

```dart
part 'test_theme_extension.g.dart';

@immutable
@myoroThemeExtension
final class TestThemeExtension extends ThemeExtension<TestThemeExtension> with _$TestThemeExtensionMixin {
```

1. Add the generated file as a `part` directive;
2. Add the `@immutable` annotation. Doesn't effect code generation, but `ThemeExtension`s are immutable by nature, so add it;
3. Add the `@myoroThemeExtension` annotation;
4. Attach the generated `mixin`.

## Want to see more examples?

`./lib` has every type of file that MFA generates for.
