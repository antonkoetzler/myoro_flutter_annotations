import 'package:flutter/material.dart';
import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';

part 'test_theme_extension.g.dart';

@myoroThemeExtension
final class TestThemeExtension extends ThemeExtension<TestThemeExtension> {
  final double hello;

  const TestThemeExtension({required this.hello});
}
