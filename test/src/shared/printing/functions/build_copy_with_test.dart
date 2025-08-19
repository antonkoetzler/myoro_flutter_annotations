import 'package:analyzer/dart/element/nullability_suffix.dart';
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
    final element = MockClassElement2(unnamedConstructor2: MockConstructorElement2());

    buildCopyWith(buffer, element);

    expect(buffer.toString(), '''
@override\n${element.nameWithTypeParameters} copyWith() {
return self;
}
''');
  });

  test('buildCopyWith: Class with multiple fields success case', () {
    final buffer = StringBuffer();
    final parameterWithoutField = MockFormalParameterElement();
    final nonNullField = MockFieldElement();
    final nullField = MockFieldElement(type: MockDartType(nullabilitySuffix: NullabilitySuffix.question));
    final element = MockClassElement2(
      unnamedConstructor2: MockConstructorElement2(
        parameters: [
          parameterWithoutField,
          MockFormalParameterElement(name: nonNullField.name3),
          MockFormalParameterElement(name: nullField.name3),
        ],
      ),
      fields: [nonNullField, nullField],
    );

    buildCopyWith(buffer, element);

    expect(buffer.toString(), '''
@override\n${element.nameWithTypeParameters} copyWith({
${parameterWithoutField.isRequired ? 'required ' : ''}${parameterWithoutField.type.getDisplayString(withNullability: true)} ${parameterWithoutField.name3},
${nonNullField.type.getDisplayString(withNullability: true)}? ${nonNullField.name3},
${nullField.type.getDisplayString(withNullability: true)} ${nullField.name3},
bool ${nullField.name3}Provided = true,
}) {
return ${element.name3}(
${parameterWithoutField.name3}: ${parameterWithoutField.name3},
${nonNullField.name3}: ${nonNullField.name3} ?? self.${nonNullField.name3},
${nullField.name3}: ${nullField.name3}Provided ? (${nullField.name3} ?? self.${nullField.name3}) : null,
);
}
''');
  });
}
