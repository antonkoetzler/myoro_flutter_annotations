import 'package:analyzer/dart/element/element.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// Builds the extension of a class.
void buildExtension(StringBuffer buffer, ClassElement element, void Function() body) {
  final extensionName = '\$${element.name}Extension${element.formattedTypeParameters}';
  buffer
    ..writeln('/// Extension class for @myoroModel to place the copyWith function.')
    ..writeln('extension $extensionName on ${element.nameWithTypeParameters} {');
  body();
  buffer.writeln('}');
}
