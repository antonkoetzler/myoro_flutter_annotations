import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:myoro_flutter_annotations/src/shared/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Builds the [copyWith] function of an annotation.
void buildCopyWith(StringBuffer buffer, ClassElement element, {required bool isThemeExtension}) {
  // ignore: deprecated_member_use — isSynthetic kept for analyzer 8.x; use isOrigin* when min analyzer is 10+
  final fields = element.mergedFields.where((field) => !field.isStatic && !field.isSynthetic).toList();
  final elementUnnamedConstructor = element.unnamedConstructor;
  final elementNameWithTypeParameters = element.nameWithTypeParameters;
  final elementName = element.name ?? '';

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
      final fieldName = field.name ?? '';
      // We must add the argument for extended fields. However, the field might not be apart of the constructor (aka a field that is called within the super() portion).
      final isArgumentInUnnamedConstructor = unnamedConstructorParameters.any((p) => p.name == field.name);

      // Use constructor parameter type for generic type parameters that need to be resolved,
      // otherwise use field type to preserve typedef names
      final constructorParameterType = isArgumentInUnnamedConstructor
          ? unnamedConstructorParameters.firstWhere((p) => p.name == field.name).type
          : null;

      final fieldType = isArgumentInUnnamedConstructor && field.type is TypeParameterType
          ? constructorParameterType!
          : field.type;

      // Check if the field type has alias information (typedef) and use that for the display string
      final fieldTypeString = fieldType.alias != null
          ? _getTypeAliasDisplayString(fieldType)
          : fieldType.getDisplayString();
      final nullabilitySuffix = fieldType.nullabilitySuffix;

      switch (nullabilitySuffix) {
        case NullabilitySuffix.star:
          throw AssertionError('[buildCopyWith]: Legacy Dart syntax is not supported.');
        case NullabilitySuffix.question:
          functionArgumentStringBuffer.writeln('$fieldTypeString $fieldName,');
          functionArgumentStringBuffer.writeln('bool ${fieldName}Provided = true,');
          if (isArgumentInUnnamedConstructor) {
            functionReturnStringBuffer.writeln(
              '$fieldName: ${fieldName}Provided ? ($fieldName ?? self.$fieldName) : null,',
            );
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
      final isNotField = !fields.any((f) => f.name == parameter.name);
      if (isNotField) {
        final parameterType = parameter.type;
        final parameterName = parameter.name ?? '';
        final parameterNullabilitySuffix = parameterType.nullabilitySuffix;

        // For non-field parameters, get the base type string WITHOUT nullability suffix
        // and then add ? manually to make them nullable in copyWith
        String parameterTypeString;
        if (parameterType.alias != null) {
          // For type aliases, get the alias name without nullability
          final alias = parameterType.alias!;
          final element = alias.element;
          final typeArguments = alias.typeArguments;

          parameterTypeString = element.name ?? '';
          if (typeArguments.isNotEmpty) {
            final typeArgumentsString = typeArguments.map((arg) => arg.getDisplayString()).join(', ');
            parameterTypeString += '<$typeArgumentsString>';
          }
        } else {
          // For regular types, use getDisplayString but remove any existing ? suffix
          parameterTypeString = parameterType.getDisplayString().replaceAll('?', '');
        }

        // The argument here must be nullable to not generate conflicting copyWith with extended classes.
        if (parameterNullabilitySuffix == NullabilitySuffix.none) {
          assertionStringBuffer.writeln('assert(');
          assertionStringBuffer.writeln('$parameterName != null,');
          assertionStringBuffer.writeln('\'[$elementName.copyWith]: [$parameterName] cannot be null.\',');
          assertionStringBuffer.writeln(');');
        }
        functionArgumentStringBuffer.writeln('$parameterTypeString? $parameterName,');
        functionReturnStringBuffer.writeln(
          '$parameterName: $parameterName${parameterNullabilitySuffix == NullabilitySuffix.none ? '!' : ''},',
        );
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

/// Gets the display string for a type alias, preserving the typedef name.
String _getTypeAliasDisplayString(DartType type) {
  final alias = type.alias!; // We know alias is not null because this function is only called when alias != null

  // Build the typedef name with type arguments
  final element = alias.element;
  final typeArguments = alias.typeArguments;

  var result = element.name ?? '';
  if (typeArguments.isNotEmpty) {
    final typeArgumentsString = typeArguments.map((arg) => arg.getDisplayString()).join(', ');
    result += '<$typeArgumentsString>';
  }

  // Add nullability suffix if needed
  final nullabilitySuffix = type.nullabilitySuffix;
  if (nullabilitySuffix == NullabilitySuffix.question) {
    result += '?';
  }

  return result;
}
