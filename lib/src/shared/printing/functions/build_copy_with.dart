import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:collection/collection.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:myoro_flutter_annotations/src/shared/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Builds the [copyWith] function of an annotation.
void buildCopyWith(StringBuffer buffer, ClassElement2 element) {
  final unnamedConstructor = element.unnamedConstructor2;
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Assert that an unnamed constructor exists
  if (unnamedConstructor == null) {
    throw InvalidGenerationSourceError(
      '[buildCopyWith]: Class ${element.nameWithTypeParameters} must have an unnamed constructor to generate copyWith.',
      element: element,
    );
  }

  // Start the function.
  buffer.writeln('@override');
  fields.isEmpty ? _emptyFieldsCase(buffer, element) : _nonEmptyFieldsCase(buffer, element, fields);
}

void _emptyFieldsCase(StringBuffer buffer, ClassElement2 element) {
  buffer.writeln('${element.nameWithTypeParameters} copyWith() {');
  buffer.writeln('return self;');
  buffer.writeln('}');
}

void _nonEmptyFieldsCase(StringBuffer buffer, ClassElement2 element, List<FieldElement2> fields) {
  final functionArgumentStringBuffer = StringBuffer();
  final functionReturnStringBuffer = StringBuffer();

  for (final parameter in element.unnamedConstructor2!.formalParameters) {
    final field = fields.firstWhereOrNull((f) => f.name3 == parameter.name3);

    // Build function args
    if (field != null) {
      final fieldType = field.type.getDisplayString(withNullability: true);
      final fieldName = field.name3;
      switch (field.type.nullabilitySuffix) {
        case NullabilitySuffix.star:
          throw AssertionError('[buildCopyWith]: Legacy Dart syntax is not supported.');
        case NullabilitySuffix.question:
          functionArgumentStringBuffer.writeln('$fieldType $fieldName,');
          functionArgumentStringBuffer.writeln('bool ${fieldName}Provided = true,');
        case NullabilitySuffix.none:
          functionArgumentStringBuffer.writeln('$fieldType? $fieldName,');
      }

      // Return args
      switch (field.type.nullabilitySuffix) {
        case NullabilitySuffix.none:
          functionReturnStringBuffer.writeln('$fieldName: $fieldName ?? self.$fieldName,');
          break;
        case NullabilitySuffix.question:
          functionReturnStringBuffer.writeln(
            '$fieldName: ${fieldName}Provided ? ($fieldName ?? self.$fieldName) : null,',
          );
          break;
        default:
          break;
      }
    } else {
      final parameterType = parameter.type.getDisplayString(withNullability: true);
      final parameterName = parameter.name3;
      final parameterIsRequired = parameter.isRequired;
      functionArgumentStringBuffer.writeln('${parameterIsRequired ? 'required ' : ''}$parameterType $parameterName,');
      functionReturnStringBuffer.writeln('$parameterName: $parameterName,');
    }
  }

  buffer.writeln('${element.nameWithTypeParameters} copyWith({');
  buffer.write(functionArgumentStringBuffer.toString());
  buffer.writeln('}) {');
  buffer.writeln('return ${element.name3}(');
  buffer.write(functionReturnStringBuffer.toString());
  buffer.writeln(');');
  buffer.writeln('}');
}
