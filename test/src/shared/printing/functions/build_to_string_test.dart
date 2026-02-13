import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../../mocks/class_element_2.mocks.dart';
import '../../../../mocks/field_element_2.mocks.dart';

void main() {
  test('buildToString', () {
    late final String expectedResult;

    final buffer = StringBuffer();
    final element = MockClassElement2(
      fields: List.generate(faker.randomGenerator.integer(10), (_) => MockFieldElement()),
    );

    buildToString(buffer, element);
    expectedResult = buffer.toString();

    buffer
      ..clear()
      ..writeln('@override')
      ..writeln('String toString() =>')
      ..writeln('\'${element.nameWithTypeParameters}(\\n\'');
    for (final field in element.fields) {
      buffer.writeln('\'  ${field.name}: \${self.${field.name}},\\n\'');
    }
    buffer.writeln('\');\';');

    expect(buffer.toString(), expectedResult);
  });
}
