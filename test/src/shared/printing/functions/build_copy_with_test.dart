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
import '../../../../mocks/instantiated_type_alias_element.mocks.dart';

void main() {
  test('buildCopyWith: No unnamedConstructor error case', () {
    final element = MockClassElement2();

    expect(
      () => buildCopyWith(StringBuffer(), element, isThemeExtension: faker.randomGenerator.boolean()),
      throwsA(
        isA<InvalidGenerationSourceError>().having(
          (e) => e.message,
          'Not [ClassElement2] message',
          contains(
            '[buildCopyWith]: Class ${element.nameWithTypeParameters} must have an unnamed constructor to generate copyWith.',
          ),
        ),
      ),
    );
  });

  test('buildCopyWith: [NullabilitySuffix.star] field error case', () {
    final starType = MockDartType(nullabilitySuffix: NullabilitySuffix.star);
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [MockFormalParameterElement(name: 'foo', type: starType)],
      ),
      fields: [MockFieldElement(name: 'foo', type: starType)],
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
      name: 'congue',
      type: MockDartType(displayString: 'praesent', nullabilitySuffix: NullabilitySuffix.question),
    );
    final nonNullableParameterWithoutField = MockFormalParameterElement(
      name: 'cum',
      type: MockDartType(displayString: 'bibendum', nullabilitySuffix: NullabilitySuffix.none),
    );
    final nullableField = MockFieldElement(
      name: 'ante',
      type: MockDartType(displayString: 'fermentum ridiculus', nullabilitySuffix: NullabilitySuffix.question),
    );
    final nonNullableField = MockFieldElement(
      name: 'mollis',
      type: MockDartType(displayString: 'consequat'),
    );
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [
          nullableParameterWithoutField,
          nonNullableParameterWithoutField,
          MockFormalParameterElement(
            name: nonNullableField.name3,
            type: MockDartType(displayString: 'consequat'),
          ),
          MockFormalParameterElement(
            name: nullableField.name3,
            type: MockDartType(displayString: 'fermentum ridiculus', nullabilitySuffix: NullabilitySuffix.question),
          ),
        ],
      ),
      fields: [nonNullableField, nullableField],
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), '''
${isThemeExtension ? '@override\n' : ''}${element.nameWithTypeParameters} copyWith({
consequat? mollis,
fermentum ridiculus ante,
bool anteProvided = true,
praesent? congue,
bibendum? cum,
}) {
assert(
cum != null,
'[${element.name3}.copyWith]: [cum] cannot be null.',
);

return ${element.name3}(
mollis: mollis ?? self.mollis,
ante: anteProvided ? (ante ?? self.ante) : null,
congue: congue,
cum: cum!,
);
}
''');
  });

  test('buildCopyWith: Type with alias (no type arguments) success case', () {
    final buffer = StringBuffer();
    final alias = MockInstantiatedTypeAliasElement(name: 'MyTypedef');
    final fieldType = MockDartType(displayString: 'MyTypedef', alias: alias);
    final field = MockFieldElement(name: 'testField', type: fieldType);
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [MockFormalParameterElement(name: 'testField', type: fieldType)],
      ),
      fields: [field],
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), contains('MyTypedef? testField,'));
  });

  test('buildCopyWith: Type with alias (with type arguments) success case', () {
    final buffer = StringBuffer();
    final typeArg1 = MockDartType(displayString: 'String');
    final typeArg2 = MockDartType(displayString: 'int');
    final alias = MockInstantiatedTypeAliasElement(name: 'MyTypedef', typeArguments: [typeArg1, typeArg2]);
    final fieldType = MockDartType(displayString: 'MyTypedef<String, int>', alias: alias);
    final field = MockFieldElement(name: 'testField', type: fieldType);
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [MockFormalParameterElement(name: 'testField', type: fieldType)],
      ),
      fields: [field],
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), contains('MyTypedef<String, int>? testField,'));
  });

  test('buildCopyWith: Type with nullable alias success case', () {
    final buffer = StringBuffer();
    final alias = MockInstantiatedTypeAliasElement(name: 'MyTypedef');
    final fieldType = MockDartType(
      displayString: 'MyTypedef?',
      alias: alias,
      nullabilitySuffix: NullabilitySuffix.question,
    );
    final field = MockFieldElement(name: 'testField', type: fieldType);
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [MockFormalParameterElement(name: 'testField', type: fieldType)],
      ),
      fields: [field],
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), contains('MyTypedef? testField,'));
  });

  test('buildCopyWith: Type with nullable alias with type arguments success case', () {
    final buffer = StringBuffer();
    final typeArg1 = MockDartType(displayString: 'String');
    final typeArg2 = MockDartType(displayString: 'int');
    final alias = MockInstantiatedTypeAliasElement(name: 'MyTypedef', typeArguments: [typeArg1, typeArg2]);
    final fieldType = MockDartType(
      displayString: 'MyTypedef<String, int>?',
      alias: alias,
      nullabilitySuffix: NullabilitySuffix.question,
    );
    final field = MockFieldElement(name: 'testField', type: fieldType);
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [MockFormalParameterElement(name: 'testField', type: fieldType)],
      ),
      fields: [field],
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), contains('MyTypedef<String, int>? testField,'));
  });

  test('buildCopyWith: Constructor parameter with type alias (not a field) success case', () {
    final buffer = StringBuffer();
    final alias = MockInstantiatedTypeAliasElement(name: 'MyTypedef');
    final parameterType = MockDartType(
      displayString: 'MyTypedef?',
      alias: alias,
      nullabilitySuffix: NullabilitySuffix.question,
    );
    final parameter = MockFormalParameterElement(name: 'testParam', type: parameterType);
    final field = MockFieldElement(
      name: 'testField',
      type: MockDartType(displayString: 'String'),
    );
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [
          parameter, // This parameter is not a field
          MockFormalParameterElement(
            name: 'testField',
            type: MockDartType(displayString: 'String'),
          ),
        ],
      ),
      fields: [field], // Has one field to trigger nonEmptyFieldsCase
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), contains('MyTypedef? testParam,'));
  });

  test('buildCopyWith: Constructor parameter with type alias with type arguments (not a field) success case', () {
    final buffer = StringBuffer();
    final typeArg1 = MockDartType(displayString: 'String');
    final typeArg2 = MockDartType(displayString: 'int');
    final alias = MockInstantiatedTypeAliasElement(name: 'MyTypedef', typeArguments: [typeArg1, typeArg2]);
    final parameterType = MockDartType(
      displayString: 'MyTypedef<String, int>?',
      alias: alias,
      nullabilitySuffix: NullabilitySuffix.question,
    );
    final parameter = MockFormalParameterElement(name: 'testParam', type: parameterType);
    final field = MockFieldElement(
      name: 'testField',
      type: MockDartType(displayString: 'String'),
    );
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [
          parameter, // This parameter is not a field
          MockFormalParameterElement(
            name: 'testField',
            type: MockDartType(displayString: 'String'),
          ),
        ],
      ),
      fields: [field], // Has one field to trigger nonEmptyFieldsCase
    );
    final isThemeExtension = faker.randomGenerator.boolean();

    buildCopyWith(buffer, element, isThemeExtension: isThemeExtension);

    expect(buffer.toString(), contains('MyTypedef<String, int>? testParam,'));
  });
}
