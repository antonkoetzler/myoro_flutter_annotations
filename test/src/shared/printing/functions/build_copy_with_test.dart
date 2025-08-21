import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import '../../../../mocks/class_element_2.mocks.dart';
import '../../../../mocks/constructor_element_2.mocks.dart';
import '../../../../mocks/dart_type.mocks.dart';
import '../../../../mocks/field_element_2.mocks.dart';
import '../../../../mocks/formal_parameter_element.mocks.dart';

void main() {
  test('buildCopyWith: No unnamedConstructor error case', () {
    final element = MockClassElement2();

    expect(
      () => buildCopyWith(StringBuffer(), element, isThemeExtension: faker.randomGenerator.boolean()),
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

  test('buildCopyWith: [NullabilitySuffix.star] field error case', () {
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(parameters: [MockFormalParameterElement(name: 'foo')]),
      fields: [
        MockFieldElement(
          name: 'foo',
          type: MockDartType(nullabilitySuffix: NullabilitySuffix.star),
        ),
      ],
    );

    expect(
      () => buildCopyWith(StringBuffer(), element, isThemeExtension: faker.randomGenerator.boolean()),
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
    final element = MockClassElement2(unnamedConstructor2: MockConstructorElement2());
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
    final nullableParameterWithoutField = MockFormalParameterElement(
      type: MockDartType(nullabilitySuffix: NullabilitySuffix.question),
    );
    final nonNullableParameterWithoutField = MockFormalParameterElement(
      type: MockDartType(nullabilitySuffix: NullabilitySuffix.none),
    );
    final nullableField = MockFieldElement(type: MockDartType(nullabilitySuffix: NullabilitySuffix.question));
    final nonNullableField = MockFieldElement();
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [
          nullableParameterWithoutField,
          nonNullableParameterWithoutField,
          MockFormalParameterElement(name: nonNullableField.name3),
          MockFormalParameterElement(name: nullableField.name3),
        ],
      ),
      fields: [nonNullableField, nullableField],
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), '''
${isThemeExtension ? '@override\n' : ''}${element.nameWithTypeParameters} copyWith({
${nonNullableField.type.getDisplayString(withNullability: true)}? ${nonNullableField.name3},
${nullableField.type.getDisplayString(withNullability: true)} ${nullableField.name3},
bool ${nullableField.name3}Provided = true,
${nullableParameterWithoutField.type.getDisplayString(withNullability: false)}? ${nullableParameterWithoutField.name3},
${nonNullableParameterWithoutField.type.getDisplayString(withNullability: false)}? ${nonNullableParameterWithoutField.name3},
}) {
assert(
${nonNullableParameterWithoutField.name3} != null,
'[${element.name3}.copyWith]: [${nonNullableParameterWithoutField.name3}] cannot be null.',
);

return ${element.name3}(
${nonNullableField.name3}: ${nonNullableField.name3} ?? self.${nonNullableField.name3},
${nullableField.name3}: ${nullableField.name3}Provided ? (${nullableField.name3} ?? self.${nullableField.name3}) : null,
${nullableParameterWithoutField.name3}: ${nullableParameterWithoutField.name3},
${nonNullableParameterWithoutField.name3}: ${nonNullableParameterWithoutField.name3}!,
);
}
''');
  });
}
