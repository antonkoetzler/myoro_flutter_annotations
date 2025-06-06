import 'package:analyzer/dart/element/element.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// Builds an extension of a class.
void buildExtension(StringBuffer buffer, ClassElement element, void Function() body) {
  final name = element.name;
  final formattedTypeParameters = element.formattedTypeParameters;

  buffer.writeln('extension \$${name}Extension$formattedTypeParameters on ${element.nameWithTypeParameters} {');
  body.call();
  buffer.writeln('}');
}
