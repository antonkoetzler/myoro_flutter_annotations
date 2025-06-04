import 'package:analyzer/dart/element/element.dart';

/// Builds a mixin of a class.
void buildMixin(StringBuffer buffer, ClassElement element, void Function() body, {String? onClass}) {
  final className = element.name;

  final mixinName = '\$${className}Mixin';
  buffer
    ..writeln('/// Apply this mixin to [$className] once the code is generated.')
    ..writeln('///')
    ..writeln('/// ```dart')
    ..writeln('/// class $className with $mixinName {}')
    ..writeln('/// ```')
    ..writeln('mixin $mixinName ${onClass != null ? 'on $onClass ' : ''}{')
    ..writeln('$className get self => this as $className;\n');
  body.call();
  buffer.writeln('}');
}
