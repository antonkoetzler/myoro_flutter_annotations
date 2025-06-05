import 'package:flutter/material.dart';
import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';

part 'myoro_app_theme_extension.g.dart';

/// [ThemeExtension] for [MyoroApp].
@myoroThemeExtension
class MyoroAppThemeExtension extends ThemeExtension<MyoroAppThemeExtension> with $MyoroAppThemeExtensionMixin {
  const MyoroAppThemeExtension();

  const MyoroAppThemeExtension.fake();

  const MyoroAppThemeExtension.builder();

  @override
  ThemeExtension<MyoroAppThemeExtension> lerp(covariant ThemeExtension<MyoroAppThemeExtension>? other, double t) {
    return this;
  }
}
