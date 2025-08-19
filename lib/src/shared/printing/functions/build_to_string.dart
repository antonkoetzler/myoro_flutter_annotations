import 'package:analyzer/dart/element/element2.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// Function that builds the [toString] override of classes.
void buildToString(StringBuffer buffer, ClassElement2 element) {
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Start the function.
  buffer
    ..writeln('@override')
    ..writeln('String toString() =>')
    ..writeln('\'${element.nameWithTypeParameters}(\\n\'');
  for (final field in fields) {
    buffer.writeln('\'  ${field.name3}: \${self.${field.name3}},\\n\'');
  }
  buffer.writeln('\');\';');
}
