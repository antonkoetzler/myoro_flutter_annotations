import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Code generator of [MyoroThemeExtension].
final class MyoroThemeExtensionGenerator extends GeneratorForAnnotation<MyoroThemeExtension> {
  const MyoroThemeExtensionGenerator();

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    // Check if element is a class
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '[MyoroModelGenerator.generateForAnnotatedElement]: [MyoroThemeExtension] can only be applied to classes.',
        element: element,
      );
    }

    final buffer = StringBuffer();

    buildMixin(buffer, element, () {
      buildCopyWith(buffer, element, isThemeExtension: true);
      buildEqualityOperator(buffer, element);
      buildHashCode(buffer, element);
      buildToString(buffer, element);
    }, onClass: 'ThemeExtension<${element.name}>');

    return formatter.format(buffer.toString());
  }
}
