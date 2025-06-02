import 'package:analyzer/dart/element/element.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

/// [ParameterElement] mock.
final class MockParameterElement extends Mock implements ParameterElement {
  MockParameterElement._();

  factory MockParameterElement({String? name}) {
    final mock = MockParameterElement._();

    when(() => mock.name).thenReturn(name ?? faker.lorem.word());

    return mock;
  }
}
