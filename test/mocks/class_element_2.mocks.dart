import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';

/// [ClassElement] mock.
final class MockClassElement2 extends Mock implements ClassElement2 {
  MockClassElement2._();

  factory MockClassElement2({
    ConstructorElement2? unnamedConstructor2,
    List<TypeParameterElement2> typeParameters2 = const [],
    List<FieldElement2> fields = const [],
  }) {
    final mock = MockClassElement2._();

    when(() => mock.unnamedConstructor2).thenReturn(unnamedConstructor2);
    when(() => mock.name3).thenReturn(faker.lorem.word());
    when(() => mock.mergedFields).thenReturn(fields);
    when(() => mock.typeParameters2).thenReturn(typeParameters2);

    return mock;
  }
}
