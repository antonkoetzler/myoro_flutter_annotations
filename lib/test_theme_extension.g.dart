// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_theme_extension.dart';

// **************************************************************************
// MyoroThemeExtensionGenerator
// **************************************************************************

/// Apply this mixin to [TestThemeExtension] once the code is generated.
///
/// ```dart
/// class TestThemeExtension with mixin $TestThemeExtensionMixin on ThemeExtension<TestThemeExtension> { { ... }
/// ```
mixin $TestThemeExtensionMixin on ThemeExtension<TestThemeExtension> {
  TestThemeExtension get self => this as TestThemeExtension;

  @override
  TestThemeExtension copyWith({double? hello}) {
    return TestThemeExtension(hello: hello ?? self.hello);
  }

  @override
  int get hashCode {
    return Object.hashAll([self.hello]);
  }

  @override
  String toString() =>
      'TestThemeExtension(\n'
      '  hello: $self.hello,\n'
      ');';
}
