import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:source_gen/source_gen.dart';

/// Builds the [copyWith] function of an annotation.
void buildCopyWith(StringBuffer buffer, ClassElement element, {bool isOverride = false}) {
  final className = element.name;
  final constructor = element.unnamedConstructor;
  final fields = element.fields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Assert that an unnamed constructor exists
  if (constructor == null) {
    throw InvalidGenerationSourceError(
      '[buildCopyWith]: Class $className must have an unnamed constructor to generate copyWith.',
      element: element,
    );
  }

  // Start the function.
  if (isOverride) buffer.writeln('@override');
  buffer.writeln('$className copyWith({');
  for (final field in fields) {
    final fieldType = field.type.name;
    final fieldName = field.name;
    if (field.type.nullabilitySuffix == NullabilitySuffix.star) _starNullabilitySuffixAssertion();
    buffer.writeln('$fieldType? $fieldName,');
    if (field.type.nullabilitySuffix == NullabilitySuffix.question) buffer.writeln('bool ${fieldName}Provided = true,');
  }
  buffer.writeln('}) {');

  // Start of the return statement.
  buffer.writeln('return $className(');
  final constructorParameters = constructor.parameters;
  final thisOrSelf = isOverride ? 'self' : 'this';
  for (final parameter in constructorParameters) {
    final parameterName = parameter.name;
    final field = fields.firstWhere(
      (f) => f.name == parameterName,
      orElse: () {
        throw InvalidGenerationSourceError(
          '[buildCopyWith]: Field for constructor parameter "$parameterName" not found in '
          'class "$className". Ensure all constructor parameters have corresponding fields.',
          element: parameter,
        );
      },
    );
    switch (field.type.nullabilitySuffix) {
      case NullabilitySuffix.none:
        buffer.writeln('$parameterName: $parameterName ?? $thisOrSelf.$parameterName,');
        break;
      case NullabilitySuffix.question:
        buffer.writeln(
          '$parameterName: ${parameterName}Provided ? ($parameterName ?? $thisOrSelf.$parameterName) : null,',
        );
        break;
      case NullabilitySuffix.star:
        _starNullabilitySuffixAssertion();
    }
  }
  buffer.writeln(');');

  // Close the function.
  buffer.writeln('}');
}

void _starNullabilitySuffixAssertion() {
  throw AssertionError('[buildCopyWith]: Legacy Dart syntax is not supported.');
}
