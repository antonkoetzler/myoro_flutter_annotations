import 'package:build/build.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Builder of [MyoroThemeExtension].
Builder myoroThemeExtensionBuilder(BuilderOptions option) {
  return SharedPartBuilder(const [MyoroThemeExtensionGenerator()], 'myoro_theme_extension');
}
