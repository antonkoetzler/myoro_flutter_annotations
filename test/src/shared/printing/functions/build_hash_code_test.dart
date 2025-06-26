import 'package:analyzer/dart/element/element.dart';
import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../../mocks/class_element.mocks.dart';
import '../../../../mocks/field_element.mocks.dart';

void main() {
  final buffer = StringBuffer();

  void testHashCode(ClassElement element, void Function() body) {
    buildHashCode(buffer..clear(), element);
    final hashCode = buffer.toString();

    buffer
      ..clear()
      ..writeln('@override')
      ..writeln('int get hashCode {');
    body.call();
    buffer.writeln('}');

    expect(hashCode, buffer.toString());
  }

  void localWriteFields(List<FieldElement> fields) {
    for (final field in fields) {
      buffer.writeln('self.${field.name},');
    }
  }

  test('buildHashCode empty case', () {
    final element = MockClassElement();
    testHashCode(element, () => buffer.writeln('return Object.hashAll(const []);'));
  });

  test('buildHashCode 1 field case', () {
    final element = MockClassElement(fields: [MockFieldElement()]);
    testHashCode(element, () {
      buffer.writeln('return Object.hashAll([');
      localWriteFields(element.fields);
      buffer.writeln(']);');
    });
  });

  test('buildHashCode 1 field or 21+ fields case', () {
    final element = MockClassElement(
      fields: List.generate(
        faker.randomGenerator.boolean() ? 1 : faker.randomGenerator.integer(100, min: 21),
        (int index) => MockFieldElement(name: 'field${index.toString()}'),
      ),
    );
    testHashCode(element, () {
      buffer.writeln('return Object.hashAll([');
      localWriteFields(element.fields);
      buffer.writeln(']);');
    });
  });

  test('buildHashCode multiple fields (but not 21) case', () {
    final element = MockClassElement(
      fields: List.generate(
        faker.randomGenerator.integer(20, min: 2),
        (int index) => MockFieldElement(name: 'field${index.toString()}'),
      ),
    );
    testHashCode(element, () {
      buffer.writeln('return Object.hash(');
      localWriteFields(element.fields);
      buffer.writeln(');');
    });
  });
}
