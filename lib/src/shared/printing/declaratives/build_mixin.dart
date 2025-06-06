import 'package:analyzer/dart/element/element.dart';
import 'package:myoro_flutter_annotations/src/shared/exports.dart';

/// Builds a mixin of a class.
void buildMixin(StringBuffer buffer, ClassElement element, void Function() body, {String? onClass}) {
  final mixinName = '\$${element.name}Mixin${element.formattedTypeParameters}';
  buffer
    ..writeln('/// Apply this mixin to [${element.name}] once the code is generated.')
    ..writeln('///')
    ..writeln('/// ```dart')
    ..writeln('/// class ${element.nameWithTypeParameters} with $mixinName {}')
    ..writeln('/// ```')
    ..writeln('mixin $mixinName ${onClass != null ? 'on $onClass ' : ''}{')
    ..writeln('${element.nameWithTypeParameters} get self => this as ${element.nameWithTypeParameters};\n');
  body.call();
  buffer.writeln('}');
}
