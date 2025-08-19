import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Code generator of [MyoroThemeExtension].
final class MyoroThemeExtensionGenerator extends GeneratorForAnnotation<MyoroThemeExtension> {
  const MyoroThemeExtensionGenerator();

  @override
  generateForAnnotatedElement(Element2 element, ConstantReader annotation, BuildStep buildStep) {
    // Check if element is a class
    if (element is! ClassElement2) {
      throw InvalidGenerationSourceError(
        '[MyoroModelGenerator.generateForAnnotatedElement]: [MyoroThemeExtension] can only be applied to classes.',
        element: element,
      );
    }

    final buffer = StringBuffer()..writeln('// coverage:ignore-file\n');

    buildMixin(buffer, element, () {
      buildCopyWith(buffer, element);
      buildEqualityOperator(buffer, element);
      buildHashCode(buffer, element);
      buildToString(buffer, element);
    }, onClass: 'ThemeExtension<${element.name3}>');

    return formatter.format(buffer.toString());
  }
}
