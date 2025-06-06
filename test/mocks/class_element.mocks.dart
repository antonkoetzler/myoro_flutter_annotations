import 'package:analyzer/dart/element/element.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// [ClassElement] mock.
final class MockClassElement extends Mock implements ClassElement {
  MockClassElement._();

  factory MockClassElement({
    ConstructorElement? unnamedConstructor,
    List<TypeParameterElement> typeParameters = const [],
    List<FieldElement> fields = const [],
  }) {
    final mock = MockClassElement._();

    when(() => mock.unnamedConstructor).thenReturn(unnamedConstructor);
    when(() => mock.name).thenReturn(faker.lorem.word());
    when(() => mock.mergedFields).thenReturn(fields);
    when(() => mock.typeParameters).thenReturn(typeParameters);

    return mock;
  }
}
