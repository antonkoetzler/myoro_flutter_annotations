import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
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

  if (fields.isEmpty) {
    _emptyFieldsCase(buffer, element, isThemeExtension);
  } else {
    _nonEmptyFieldsCase(buffer, element, fields, isThemeExtension);
  }
}

String thisOrSelf(bool isThemeExtension) => isThemeExtension ? 'self' : 'this';

void _emptyFieldsCase(StringBuffer buffer, ClassElement element, bool isThemeExtension) {
  buffer.writeln('${element.name}${element.formattedTypeParameters} copyWith() {');
  buffer.writeln('return ${thisOrSelf(isThemeExtension)};');
  buffer.writeln('}');
}

void _nonEmptyFieldsCase(StringBuffer buffer, ClassElement element, List<FieldElement> fields, bool isThemeExtension) {
  buffer.writeln('${element.name}${element.formattedTypeParameters} copyWith({');
  for (final field in fields) {
    final fieldType = field.type.getDisplayString(withNullability: false);
    final fieldName = field.name;
    if (field.type.nullabilitySuffix == NullabilitySuffix.star) {
      throw _starNullabilitySuffixAssertion();
    }
    buffer.writeln('$fieldType? $fieldName,');
    if (field.type.nullabilitySuffix == NullabilitySuffix.question) {
      buffer.writeln('bool ${fieldName}Provided = true,');
    }
  }
  buffer.writeln('}) {');

  // Start of the return statement.
  buffer.writeln('return ${element.name}(');
  final unnamedConstructorParameters = element.unnamedConstructor!.parameters;
  for (final parameter in unnamedConstructorParameters) {
    final parameterName = parameter.name;

    final field = fields.firstWhere(
      (f) => f.name == parameterName,
      orElse: () => throw _invalidConstructorParameterAssertion(element, parameter),
    );
    final fieldType = field.type.nullabilitySuffix;
    if (fieldType == NullabilitySuffix.none) {
      buffer.writeln('$parameterName: $parameterName ?? ${thisOrSelf(isThemeExtension)}.$parameterName,');
    }
    if (fieldType == NullabilitySuffix.question) {
      buffer.writeln(
        '$parameterName: ${parameterName}Provided ? ($parameterName ?? ${thisOrSelf(isThemeExtension)}.$parameterName) : null,',
      );
    }
  }
  buffer.writeln(');');
  buffer.writeln('}');
}

InvalidGenerationSourceError _invalidConstructorAssertion(ClassElement element) {
  return InvalidGenerationSourceError(
    '[buildCopyWith]: Class ${element.name}${element.formattedTypeParameters} must have an unnamed constructor to generate copyWith.',
    element: element,
  );
}

AssertionError _starNullabilitySuffixAssertion() {
  return AssertionError('[buildCopyWith]: Legacy Dart syntax is not supported.');
}

InvalidGenerationSourceError _invalidConstructorParameterAssertion(ClassElement element, ParameterElement parameter) {
  return InvalidGenerationSourceError(
    '[buildCopyWith]: Field for constructor parameter "${parameter.name}" not found in '
    'class "${element.name}". Ensure all constructor parameters have corresponding fields.',
    element: parameter,
  );
}
