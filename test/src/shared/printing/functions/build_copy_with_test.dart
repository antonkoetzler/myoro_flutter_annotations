import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import '../../../../mocks/class_element.mocks.dart';
import '../../../../mocks/constructor_element.mocks.dart';
import '../../../../mocks/dart_type.mocks.dart';
import '../../../../mocks/field_element.mocks.dart';
import '../../../../mocks/parameter_element.mocks.dart';

void main() {
  test('buildCopyWith: No unnamedConstructor error case', () {
    final element = MockClassElement();

    expect(
      () => buildCopyWith(StringBuffer(), element),
      throwsA(
        isA<InvalidGenerationSourceError>().having(
          (e) => e.message,
          'Not [ClassElement] message',
          contains(
            '[buildCopyWith]: Class ${element.nameWithTypeParameters} must have an unnamed constructor to generate copyWith.',
          ),
        ),
      ),
    );
  });

  test('buildCopyWith: unnamedConstructor with arguments that do not match field\'s names error case', () {
    final element = MockClassElement(
      unnamedConstructor: MockConstructorElement(parameters: [MockParameterElement(name: 'bar')]),
      fields: [MockFieldElement(name: 'foo')],
    );
    final parameterName = element.unnamedConstructor!.parameters.first.name;

    expect(
      () => buildCopyWith(StringBuffer(), element),
      throwsA(
        isA<InvalidGenerationSourceError>().having(
          (e) => e.message,
          'Parameter message',
          contains(
            '[buildCopyWith]: Field for constructor parameter "$parameterName" not found in class "${element.name}". Ensure all constructor parameters have corresponding fields.',
          ),
        ),
      ),
    );
  });

  test('buildCopyWith: [NullabilitySuffix.star] field error case', () {
    final element = MockClassElement(
      unnamedConstructor: MockConstructorElement(parameters: [MockParameterElement(name: 'foo')]),
      fields: [
        MockFieldElement(
          name: 'foo',
          type: MockDartType(nullabilitySuffix: NullabilitySuffix.star),
        ),
      ],
    );

    expect(
      () => buildCopyWith(StringBuffer(), element),
      throwsA(
        isA<AssertionError>().having(
          (e) => e.message,
          '[NullabilitySuffix.star] exception',
          '[buildCopyWith]: Legacy Dart syntax is not supported.',
        ),
      ),
    );
  });

  test('buildCopyWith: Class with 0 fields success case', () {
    final buffer = StringBuffer();
    final element = MockClassElement(unnamedConstructor: MockConstructorElement());
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), '''
${isThemeExtension ? '@override\n' : ''}${element.nameWithTypeParameters} copyWith() {
return self;
}
''');
  });

  test('buildCopyWith: Class with multiple fields success case', () {
    final buffer = StringBuffer();
    final nonNullField = MockFieldElement();
    final nullField = MockFieldElement(type: MockDartType(nullabilitySuffix: NullabilitySuffix.question));
    final element = MockClassElement(
      unnamedConstructor: MockConstructorElement(
        parameters: [
          MockParameterElement(name: nonNullField.name),
          MockParameterElement(name: nullField.name),
        ],
      ),
      fields: [nonNullField, nullField],
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), '''
${isThemeExtension ? '@override\n' : ''}${element.nameWithTypeParameters} copyWith({
${nonNullField.type.getDisplayString(withNullability: true)}? ${nonNullField.name},
${nullField.type.getDisplayString(withNullability: true)} ${nullField.name},
bool ${nullField.name}Provided = true,
}) {
return ${element.name}(
${nonNullField.name}: ${nonNullField.name} ?? self.${nonNullField.name},
${nullField.name}: ${nullField.name}Provided ? (${nullField.name} ?? self.${nullField.name}) : null,
);
}
''');
  });
}
