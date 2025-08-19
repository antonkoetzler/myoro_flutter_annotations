import 'package:analyzer/dart/element/element2.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// Builds the == operator override of a class.
void buildEqualityOperator(StringBuffer buffer, ClassElement2 element) {
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Start the function.
  buffer.writeln('@override');
  buffer.writeln('bool operator ==(Object other) {');

  // Start of the return statement.
  buffer.writeln('return other is ${element.nameWithTypeParameters} &&');
  buffer.writeln('other.runtimeType == runtimeType${fields.isEmpty ? ';' : ' &&'}');
  for (int i = 0; i < fields.length; i++) {
    final fieldName = fields[i].name3;
    buffer.writeln('other.$fieldName == self.$fieldName${(i == fields.length - 1) ? ';' : ' &&'}');
  }

  // Close the function.
  buffer.writeln('}');
}
