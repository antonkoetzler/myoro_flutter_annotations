import 'package:analyzer/dart/element/element.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// Builds the [hashCode] getter override of a class.
void buildHashCode(StringBuffer buffer, ClassElement element) {
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Start the getter.
  buffer.writeln('@override');
  buffer.writeln('int get hashCode {');

  // Start the return statement.
  if (fields.isEmpty) {
    buffer.writeln('return Object.hashAll(const []);');
  } else if (fields.length == 1 || fields.length == 20) {
    buffer.writeln('return Object.hashAll([');
    _writeFields(buffer, fields);
    buffer.writeln(']);');
  } else {
    buffer.writeln('return Object.hash(');
    _writeFields(buffer, fields);
    buffer.writeln(');');
  }

  // Close the getter.
  buffer.writeln('}');
}

void _writeFields(StringBuffer buffer, List<FieldElement> fields) {
  for (final field in fields) {
    buffer.writeln('self.${field.name},');
  }
}
