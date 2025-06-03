import 'package:analyzer/dart/element/element.dart';
import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../mocks/class_element.mocks.dart';
import '../../../mocks/field_element.mocks.dart';

void main() {
  final buffer = StringBuffer();

  void testHashCode(ClassElement classElement, void Function() body) {
    buildHashCode(buffer..clear(), classElement);
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
    final classElement = MockClassElement();
    testHashCode(classElement, () => buffer.writeln('return Object.hashAll(const []);'));
  });

  test('buildHashCode 1 field case', () {
    final classElement = MockClassElement(fields: [MockFieldElement()]);
    testHashCode(classElement, () {
      buffer.writeln('return Object.hashAll([');
      localWriteFields(classElement.fields);
      buffer.writeln(']);');
    });
  });

  test('buildHashCode 20 fields case', () {
    final classElement = MockClassElement(
      fields: List.generate(20, (int index) => MockFieldElement(name: 'field${index.toString()}')),
    );
    testHashCode(classElement, () {
      buffer.writeln('return Object.hashAll([');
      localWriteFields(classElement.fields);
      buffer.writeln(']);');
    });
  });

  test('buildHashCode multiple fields (but not 20) case', () {
    final classElement = MockClassElement(
      fields: List.generate(
        faker.randomGenerator.integer(19, min: 2),
        (int index) => MockFieldElement(name: 'field${index.toString()}'),
      ),
    );
    testHashCode(classElement, () {
      buffer.writeln('return Object.hash(');
      localWriteFields(classElement.fields);
      buffer.writeln(');');
    });
  });
}
