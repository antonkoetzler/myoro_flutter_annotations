import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:collection/collection.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:myoro_flutter_annotations/src/shared/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Builds the [copyWith] function of an annotation.
void buildCopyWith(StringBuffer buffer, ClassElement element, {bool isThemeExtension = false}) {
  final unnamedConstructor = element.unnamedConstructor;
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Assert that an unnamed constructor exists
  if (unnamedConstructor == null) throw _invalidConstructorAssertion(element);

  // Start the function.
  if (isThemeExtension) buffer.writeln('@override');

  fields.isEmpty
      ? _emptyFieldsCase(buffer, element, isThemeExtension)
      : _nonEmptyFieldsCase(buffer, element, fields, isThemeExtension);
}

void _emptyFieldsCase(StringBuffer buffer, ClassElement element, bool isThemeExtension) {
  buffer.writeln('${element.nameWithTypeParameters} copyWith() {');
  buffer.writeln('return self;');
  buffer.writeln('}');
}

void _nonEmptyFieldsCase(StringBuffer buffer, ClassElement element, List<FieldElement> fields, bool isThemeExtension) {
  buffer.writeln('${element.nameWithTypeParameters} copyWith({');
  for (final field in fields) {
    final fieldType = field.type.getDisplayString(withNullability: true);
    final fieldName = field.name;
    switch (field.type.nullabilitySuffix) {
      case NullabilitySuffix.star:
        throw _starNullabilitySuffixAssertion();
      case NullabilitySuffix.question:
        buffer.writeln('$fieldType $fieldName,');
        buffer.writeln('bool ${fieldName}Provided = true,');
      case NullabilitySuffix.none:
        buffer.writeln('$fieldType? $fieldName,');
    }
  }
  buffer.writeln('}) {');

  // Start of the return statement.
  buffer.writeln('return ${element.name}(');
  final unnamedConstructorParameters = element.unnamedConstructor!.parameters;
  for (final parameter in unnamedConstructorParameters) {
    final parameterName = parameter.name;

    final field = fields.firstWhereOrNull((f) => f.name == parameterName);
    if (field != null) {
      final fieldType = field.type.nullabilitySuffix;
      if (fieldType == NullabilitySuffix.none) {
        buffer.writeln('$parameterName: $parameterName ?? self.$parameterName,');
      }
      if (fieldType == NullabilitySuffix.question) {
        buffer.writeln('$parameterName: ${parameterName}Provided ? ($parameterName ?? self.$parameterName) : null,');
      }
    }
  }
  buffer.writeln(');');
  buffer.writeln('}');
}

InvalidGenerationSourceError _invalidConstructorAssertion(ClassElement element) {
  return InvalidGenerationSourceError(
    '[buildCopyWith]: Class ${element.nameWithTypeParameters} must have an unnamed constructor to generate copyWith.',
    element: element,
  );
}

AssertionError _starNullabilitySuffixAssertion() {
  return AssertionError('[buildCopyWith]: Legacy Dart syntax is not supported.');
}
