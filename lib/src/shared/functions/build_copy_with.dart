import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:source_gen/source_gen.dart';

/// Builds the [copyWith] function of an annotation.
void buildCopyWith(StringBuffer buffer, ClassElement element) {
  final className = element.name;
  final constructor = element.unnamedConstructor;
  final fields = element.fields.where((field) => !field.isStatic && !field.isSynthetic).toList();

  // Start the function.
  buffer.writeln('  $className copyWith({');
  for (final field in fields) {
    final fieldType = field.type.getDisplayString();
    final fieldName = field.name;
    (field.type.nullabilitySuffix != NullabilitySuffix.none)
        ? (buffer
          ..writeln('    $fieldType $fieldName,')
          ..writeln('    bool ${fieldName}Provided = true,'))
        : buffer.writeln('    $fieldType? $fieldName,');
  }
  buffer.writeln('  }) {');

  // Assert that an unnamed constructor exists
  if (constructor == null) {
    throw InvalidGenerationSourceError(
      'Class $className must have an unnamed constructor to generate copyWith.',
      element: element,
    );
  }

  // Start of the return statement.
  buffer.writeln('    return $className(');
  final constructorParameters = constructor.parameters;
  for (final parameter in constructorParameters) {
    final parameterName = parameter.name;

    final field = fields.firstWhere(
      (f) => f.name == parameterName,
      orElse: () {
        throw InvalidGenerationSourceError(
          'Field for constructor parameter "$parameterName" not found in class "$className". '
          'Ensure all constructor parameters have corresponding fields.',
          element: parameter,
        );
      },
    );

    (field.type.nullabilitySuffix != NullabilitySuffix.none)
        ? buffer.writeln(
          '      $parameterName: ${parameterName}Provided ? ($parameterName ?? this.$parameterName) : null,',
        )
        : buffer.writeln('      $parameterName: $parameterName ?? this.$parameterName,');
  }
  buffer.writeln('    );');

  // Close the function.
  buffer.writeln('  }');
}
