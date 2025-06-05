import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import '../../../mocks/class_element.mocks.dart';
import '../../../mocks/constructor_element.mocks.dart';
import '../../../mocks/dart_type.mocks.dart';
import '../../../mocks/field_element.mocks.dart';
import '../../../mocks/parameter_element.mocks.dart';

void main() {
  test('buildCopyWith: No unnamedConstructor error case', () {
    final element = MockClassElement();
    final className = element.name;

    expect(
      () => buildCopyWith(StringBuffer(), element),
      throwsA(
        isA<InvalidGenerationSourceError>().having(
          (e) => e.message,
          'Not [ClassElement] message',
          contains('[buildCopyWith]: Class $className must have an unnamed constructor to generate copyWith.'),
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
    final className = element.name;

    expect(
      () => buildCopyWith(StringBuffer(), element),
      throwsA(
        isA<InvalidGenerationSourceError>().having(
          (e) => e.message,
          'Parameter message',
          contains(
            '[buildCopyWith]: Field for constructor parameter "$parameterName" not found in class "$className". Ensure all constructor parameters have corresponding fields.',
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

  test('buildCopyWith: Success case', () {
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
    final isOverride = faker.randomGenerator.boolean();
    final thisOrSelf = isOverride ? 'self' : 'this';

    buildCopyWith(buffer, element, isOverride: isOverride);

    expect(buffer.toString(), '''
${isOverride ? '@override\n' : ''}${element.name} copyWith({
${nonNullField.type.getDisplayString(withNullability: false)}? ${nonNullField.name},
${nullField.type.getDisplayString(withNullability: false)}? ${nullField.name},
bool ${nullField.name}Provided = true,
}) {
return ${element.name}(
${nonNullField.name}: ${nonNullField.name} ?? $thisOrSelf.${nonNullField.name},
${nullField.name}: ${nullField.name}Provided ? (${nullField.name} ?? $thisOrSelf.${nullField.name}) : null,
);
}
''');
  });
}
