import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:myoro_flutter_annotations/src/shared/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Builds the [copyWith] function of an annotation.
void buildCopyWith(StringBuffer buffer, ClassElement2 element, {required bool isThemeExtension}) {
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();
  final elementUnnamedConstructor = element.unnamedConstructor2;
  final elementNameWithTypeParameters = element.nameWithTypeParameters;
  final elementName = element.name3;

  void emptyFieldsCase() {
    buffer.writeln('$elementNameWithTypeParameters copyWith() {');
    buffer.writeln('return self;');
    buffer.writeln('}');
  }

  void nonEmptyFieldsCase() {
    final assertionStringBuffer = StringBuffer();
    final functionArgumentStringBuffer = StringBuffer();
    final functionReturnStringBuffer = StringBuffer();
    final unnamedConstructorParameters = elementUnnamedConstructor!.formalParameters;

    for (final field in fields) {
      final fieldType = field.type;
      final fieldTypeString = fieldType.getDisplayString(withNullability: true);
      final fieldName = field.name3;
      final nullabilitySuffix = fieldType.nullabilitySuffix;
      // We must add the argument for extended fields. However, the field might not be apart of the constructor (aka a field that is called within the super() portion).
      final isArgumentInUnnamedConstructor = unnamedConstructorParameters.any((p) => p.name3 == field.name3);

      switch (nullabilitySuffix) {
        case NullabilitySuffix.star:
          throw AssertionError('[buildCopyWith]: Legacy Dart syntax is not supported.');
        case NullabilitySuffix.question:
          functionArgumentStringBuffer.writeln('$fieldTypeString $fieldName,');
          functionArgumentStringBuffer.writeln('bool ${fieldName}Provided = true,');
          if (isArgumentInUnnamedConstructor) {
            functionReturnStringBuffer.writeln('$fieldName: ${fieldName}Provided ? ($fieldName ?? self.$fieldName) : null,');
          }
        case NullabilitySuffix.none:
          functionArgumentStringBuffer.writeln('$fieldTypeString? $fieldName,');
          if (isArgumentInUnnamedConstructor) {
            functionReturnStringBuffer.writeln('$fieldName: $fieldName ?? self.$fieldName,');
          }
      }
    }

    // For parameters that are not fields.
    for (final parameter in unnamedConstructorParameters) {
      final isNotField = !fields.any((f) => f.name3 == parameter.name3);
      if (isNotField) {
        final parameterType = parameter.type;
        final parameterTypeString = parameterType.getDisplayString(withNullability: false);
        final parameterName = parameter.name3;
        final parameterNullabilitySuffix = parameterType.nullabilitySuffix;
        // The argument here must be nullable to not generate conflicting copyWith with extended classes.
        if (parameterNullabilitySuffix == NullabilitySuffix.none) {
          assertionStringBuffer.writeln('assert(');
          assertionStringBuffer.writeln('$parameterName != null,');
          assertionStringBuffer.writeln('\'[$elementName.copyWith]: [$parameterName] cannot be null.\',');
          assertionStringBuffer.writeln(');');
        }
        functionArgumentStringBuffer.writeln('$parameterTypeString? $parameterName,');
        functionReturnStringBuffer.writeln('$parameterName: $parameterName${parameterNullabilitySuffix == NullabilitySuffix.none ? '!' : ''},');
      }
    }

    buffer.writeln('$elementNameWithTypeParameters copyWith({');
    buffer.write(functionArgumentStringBuffer.toString());
    buffer.writeln('}) {');
    final assertionString = assertionStringBuffer.toString();
    if (assertionString.isNotEmpty) buffer.writeln(assertionString);
    buffer.writeln('return $elementName(');
    buffer.write(functionReturnStringBuffer.toString());
    buffer.writeln(');');
    buffer.writeln('}');
  }

  // Assert that an unnamed constructor exists
  if (elementUnnamedConstructor == null) {
    throw InvalidGenerationSourceError(
      '[buildCopyWith]: Class $elementNameWithTypeParameters must have an unnamed constructor to generate copyWith.',
      element: element,
    );
  }

  // Start the function.
  if (isThemeExtension) buffer.writeln('@override');
  fields.isEmpty ? emptyFieldsCase() : nonEmptyFieldsCase();
}
