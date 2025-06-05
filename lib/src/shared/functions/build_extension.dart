import 'package:analyzer/dart/element/element.dart';

/// Builds an extension of a class.
void buildExtension(StringBuffer buffer, ClassElement element, void Function() body) {
  final className = element.name;
  buffer.writeln('extension \$${className}Extension on $className {');
  body.call();
  buffer.writeln('}');
}
