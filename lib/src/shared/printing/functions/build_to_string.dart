import 'package:analyzer/dart/element/element.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// Function that builds the [toString] override of classes.
void buildToString(StringBuffer buffer, ClassElement element) {
  // ignore: deprecated_member_use — isSynthetic kept for analyzer 8.x; use isOrigin* when min analyzer is 10+
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Start the function.
  buffer
    ..writeln('@override')
    ..writeln('String toString() =>')
    ..writeln('\'${element.nameWithTypeParameters}(\\n\'');
  for (final field in fields) {
    final n = field.name ?? '';
    buffer.writeln('\'  $n: \${self.$n},\\n\'');
  }
  buffer.writeln('\');\';');
}
