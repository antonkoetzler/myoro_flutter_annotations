import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';

part 'test_theme_extension.g.dart';

@myoroThemeExtension
final class TestThemeExtension extends ThemeExtension<TestThemeExtension> with _$TestThemeExtensionMixin {
  const TestThemeExtension({required this.spacing, required this.padding});

  final double spacing;
  final double? padding;

  @override
  TestThemeExtension lerp(covariant ThemeExtension<ThemeExtension>? other, double t) {
    if (other is! TestThemeExtension) return this;
    return copyWith(spacing: lerpDouble(spacing, other.spacing, t), padding: lerpDouble(padding, other.padding, t));
  }
}
