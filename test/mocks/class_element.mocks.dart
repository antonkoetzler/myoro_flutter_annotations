import 'package:analyzer/dart/element/element.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

/// [ClassElement] mock.
final class MockClassElement extends Mock implements ClassElement {
  MockClassElement._();

  factory MockClassElement({ConstructorElement? unnamedConstructor, List<FieldElement> fields = const []}) {
    final mock = MockClassElement._();

    when(() => mock.unnamedConstructor).thenReturn(unnamedConstructor);
    when(() => mock.name).thenReturn(faker.lorem.word());
    when(() => mock.fields).thenReturn(fields);

    return mock;
  }
}
