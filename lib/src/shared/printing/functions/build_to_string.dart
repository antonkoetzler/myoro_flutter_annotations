import 'package:analyzer/dart/element/element.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// Function that builds the [toString] override of classes.
void buildToString(StringBuffer buffer, ClassElement element) {
  final formattedTypeParameters = element.formattedTypeParameters;
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Start the function.
  buffer
    ..writeln('@override')
    ..writeln('String toString() =>')
    ..writeln('\'${element.name}$formattedTypeParameters(\\n\'');
  for (final field in fields) {
    buffer.writeln('\'  ${field.name}: \${self.${field.name}},\\n\'');
  }
  buffer.writeln('\');\';');
}
