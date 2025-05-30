import 'package:analyzer/dart/element/element.dart';

/// Builds the == operator override of a class.
void buildEqualityOperator(StringBuffer buffer, ClassElement element) {
  final className = element.name;
  final fields = element.fields.where((field) => !field.isStatic).toList();

  // Start the function.
  buffer.writeln('  @override');
  buffer.writeln('  bool operator ==(Object other) {');

  // Start of the return statement.
  buffer.writeln('    return other is $className &&');
  buffer.writeln('        other.runtimeType == runtimeType${fields.isEmpty ? ';' : ' &&'}');
  for (int i = 0; i < fields.length; i++) {
    final fieldName = fields[i].name;
    buffer.writeln('        other.$fieldName == self.$fieldName${(i == fields.length - 1) ? ';' : ' &&'}');
  }

  // Close the function.
  buffer.writeln('  }');
}
