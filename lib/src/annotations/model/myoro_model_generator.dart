import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';
import 'package:source_gen/source_gen.dart';

/// Code generator of [MyoroModel].
class MyoroModelGenerator extends GeneratorForAnnotation<MyoroModel> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    // Check if element is a class
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '[MyoroModelGenerator.generateForAnnotatedElement]: MyoroModel can only be applied to classes.',
        element: element,
      );
    }

    // Class in which the code is being generated for.
    final className = element.name;

    // [StringBuffer] to write the generated code.
    final buffer = StringBuffer();

    // Start of the extension of the class with the code being generated.
    buffer.writeln('extension \$${className}Extension on $className {');
    buildCopyWith(buffer, element);
    buffer.writeln('}');

    // Start of the mixin of the class with the code being generated.
    final mixinName = 'mixin \$${className}Mixin {';
    buffer.writeln('/// Apply this mixin to [$className] once the code is generated.');
    buffer.writeln('///');
    buffer.writeln('/// ```dart');
    buffer.writeln('/// class $className with $mixinName { ... }');
    buffer.writeln('/// ```');
    buffer.writeln(mixinName);
    buffer.writeln('  $className get self => this as $className;\n');
    buildEqualityOperator(buffer, element);
    buildHashCode(buffer, element);
    buildToString(buffer, element);
    buffer.writeln('}');

    return DartFormatter().format(buffer.toString());
  }
}
