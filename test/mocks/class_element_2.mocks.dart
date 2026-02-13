import 'package:analyzer/dart/element/element.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

/// [ClassElement] mock.
final class MockClassElement2 extends Mock implements ClassElement {
  MockClassElement2._();

  factory MockClassElement2({
    ConstructorElement? unnamedConstructor,
    List<TypeParameterElement> typeParameters = const [],
    List<FieldElement> fields = const [],
  }) {
    final mock = MockClassElement2._();

    when(() => mock.unnamedConstructor).thenReturn(unnamedConstructor);
    when(() => mock.name).thenReturn(faker.lorem.word());
    when(() => mock.fields).thenReturn(fields);
    when(() => mock.typeParameters).thenReturn(typeParameters);

    return mock;
  }
}
