import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:source_gen/source_gen.dart';

/// Builds the [copyWith] function of an annotation.
void buildCopyWith(StringBuffer buffer, ClassElement element, {bool isOverride = false}) {
  final className = element.name;
  final constructor = element.unnamedConstructor;
  final fields = element.fields.where((field) => !field.isStatic && !field.isSynthetic).toList();
  final thisOrSelf = isOverride ? 'self' : 'this';

  // Assert that an unnamed constructor exists
  if (constructor == null) throw _invalidConstructorAssertion(element);

  // Start the function.
  if (isOverride) buffer.writeln('@override');

  if (fields.isEmpty) {
    buffer.writeln('$className copyWith() {');
    buffer.writeln('return $thisOrSelf;');
    buffer.writeln('}');
  } else {
    buffer.writeln('$className copyWith({');
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
    buffer.writeln('return $className(');
    final constructorParameters = constructor.parameters;
    for (final parameter in constructorParameters) {
      final parameterName = parameter.name;
      final field = fields.firstWhere(
        (f) => f.name == parameterName,
        orElse: () => throw _invalidConstructorParameterAssertion(element, parameter),
      );
      final fieldType = field.type.nullabilitySuffix;
      if (fieldType == NullabilitySuffix.none) {
        buffer.writeln('$parameterName: $parameterName ?? $thisOrSelf.$parameterName,');
      }
      if (fieldType == NullabilitySuffix.question) {
        buffer.writeln(
          '$parameterName: ${parameterName}Provided ? ($parameterName ?? $thisOrSelf.$parameterName) : null,',
        );
      }
    }
    buffer.writeln(');');
    buffer.writeln('}');
  }
}

InvalidGenerationSourceError _invalidConstructorAssertion(ClassElement element) {
  return InvalidGenerationSourceError(
    '[buildCopyWith]: Class ${element.name} must have an unnamed constructor to generate copyWith.',
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
