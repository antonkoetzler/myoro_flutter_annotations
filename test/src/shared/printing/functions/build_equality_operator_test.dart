import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../../mocks/class_element_2.mocks.dart';
import '../../../../mocks/field_element_2.mocks.dart';

void main() {
  test('buildEqualityOperator empty case', () {
    final buffer = StringBuffer();
    final element = MockClassElement2();

    buildEqualityOperator(buffer, element);

    expect(buffer.toString(), '''
@override
bool operator ==(Object other) {
return other is ${element.name3} &&
other.runtimeType == runtimeType;
}
''');
  });

  test('buildEqualityOperator non-empty case', () {
    late final String result;

    final buffer = StringBuffer();
    final element = MockClassElement2(
      fields: List.generate(faker.randomGenerator.integer(10, min: 1), (_) => MockFieldElement()),
    );

    buildEqualityOperator(buffer, element);
    result = buffer.toString();

    buffer
      ..clear()
      ..writeln('@override')
      ..writeln('bool operator ==(Object other) {')
      ..writeln('return other is ${element.nameWithTypeParameters} &&')
      ..writeln('other.runtimeType == runtimeType &&');
    final fieldsLength = element.fields2.length;
    for (int i = 0; i < fieldsLength; i++) {
      final field = element.fields2[i];
      buffer.writeln('other.${field.name3} == self.${field.name3}${(i == fieldsLength - 1) ? ';' : ' &&'}');
    }
    buffer.writeln('}');

    expect(result, buffer.toString());
  });
}
