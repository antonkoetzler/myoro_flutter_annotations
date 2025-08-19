// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_theme_extension.dart';

// **************************************************************************
// MyoroThemeExtensionGenerator
// **************************************************************************

/// Apply this mixin to [TestThemeExtension] once the code is generated.
///
/// ```dart
/// class TestThemeExtension with _$TestThemeExtensionMixin {}
/// ```
mixin _$TestThemeExtensionMixin on ThemeExtension<TestThemeExtension> {
  TestThemeExtension get self => this as TestThemeExtension;

  @override
  TestThemeExtension copyWith({
    double? spacing,
    double? padding,
    bool paddingProvided = true,
  }) {
    return TestThemeExtension(
      spacing: spacing ?? self.spacing,
      padding: paddingProvided ? (padding ?? self.padding) : null,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TestThemeExtension &&
        other.runtimeType == runtimeType &&
        other.spacing == self.spacing &&
        other.padding == self.padding;
  }

  @override
  int get hashCode {
    return Object.hash(self.spacing, self.padding);
  }

  @override
  String toString() =>
      'TestThemeExtension(\n'
      '  spacing: ${self.spacing},\n'
      '  padding: ${self.padding},\n'
      ');';
}
