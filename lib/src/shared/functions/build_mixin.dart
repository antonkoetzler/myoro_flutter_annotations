import 'package:analyzer/dart/element/element.dart';

/// Builds a mixin of a class.
void buildMixin(
  StringBuffer buffer,
  ClassElement element,
  void Function() body,
) {
  final className = element.name;

  final mixinName = 'mixin \$${className}Mixin {';
  buffer.writeln(
    '/// Apply this mixin to [$className] once the code is generated.',
  );
  buffer.writeln('///');
  buffer.writeln('/// ```dart');
  buffer.writeln('/// class $className with $mixinName { ... }');
  buffer.writeln('/// ```');
  buffer.writeln(mixinName);
  buffer.writeln('  $className get self => this as $className;\n');
  body.call();
  buffer.writeln('}');
}
