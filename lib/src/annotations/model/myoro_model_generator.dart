import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Code generator of [MyoroModel].
final class MyoroModelGenerator extends GeneratorForAnnotation<MyoroModel> {
  const MyoroModelGenerator();

  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    // Check if element is a class
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError('[MyoroModelGenerator.generateForAnnotatedElement]: MyoroModel can only be applied to classes.', element: element);
    }

    final buffer = StringBuffer();

    buildExtension(buffer, element, () => buildCopyWith(buffer, element));

    buildMixin(buffer, element, () {
      buildEqualityOperator(buffer, element);
      buildHashCode(buffer, element);
      buildToString(buffer, element);
    });

    return formatter.format(buffer.toString());
  }
}
