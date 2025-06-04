import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../mocks/class_element.mocks.dart';
import '../../../mocks/constructor_element.mocks.dart';
import '../../../mocks/dart_type.mocks.dart';
import '../../../mocks/field_element.mocks.dart';
import '../../../mocks/parameter_element.mocks.dart';

void main() {
  test('buildCopyWith: Error case', () {
    expect(() => buildCopyWith(StringBuffer(), MockClassElement()), throwsException);
  });

  test('buildCopyWith: Success case', () {
    final buffer = StringBuffer();
    final nonNullField = MockFieldElement();
    final nullField = MockFieldElement(type: MockDartType(nullabilitySuffix: NullabilitySuffix.question));
    final element = MockClassElement(
      unnamedConstructor: MockConstructorElement(
        parameters: [MockParameterElement(name: nonNullField.name), MockParameterElement(name: nullField.name)],
      ),
      fields: [nonNullField, nullField],
    );
    final isOverride = faker.randomGenerator.boolean();
    final thisOrSelf = isOverride ? 'self' : 'this';

    buildCopyWith(buffer, element, isOverride: isOverride);

    expect(buffer.toString(), '''
${isOverride ? '@override\n' : ''}${element.name} copyWith({
${nonNullField.type.name}? ${nonNullField.name},
${nullField.type.name}? ${nullField.name},
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
