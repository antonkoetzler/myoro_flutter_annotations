import 'package:analyzer/dart/element/element.dart';

/// Function that builds the [toString] override of classes.
void buildToString(StringBuffer buffer, ClassElement element) {
  final className = element.name;
  final fields =
      element.fields
          .where((field) => !field.isStatic && !field.isSynthetic)
          .toList();

  // Start the function.
  buffer.writeln('@override');
  buffer.writeln('String toString() =>');
  buffer.writeln('\'$className(\\n\'');
  for (final field in fields) {
    buffer.writeln('\'  ${field.name}: \${self.${field.name}},\\n\'');
  }
  buffer.writeln('\');\';');
}
