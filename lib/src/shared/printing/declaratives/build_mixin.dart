import 'package:analyzer/dart/element/element2.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// Builds the mixin of a class.
void buildMixin(StringBuffer buffer, ClassElement2 element, void Function() body, {String? onClass}) {
  final mixinName = '_\$${element.name3}Mixin${element.formattedTypeParameters}';
  buffer
    ..writeln('/// Apply this mixin to [${element.name3}] once the code is generated.')
    ..writeln('///')
    ..writeln('/// ```dart')
    ..writeln('/// class ${element.nameWithTypeParameters} with $mixinName {}')
    ..writeln('/// ```')
    ..writeln('mixin $mixinName ${onClass != null ? 'on $onClass ' : ''}{')
    ..writeln('${element.nameWithTypeParameters} get self => this as ${element.nameWithTypeParameters};\n');
  body();
  buffer.writeln('}');
}
