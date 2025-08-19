import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'dart_type.mocks.dart';

/// [ParameterElement] mock.
final class MockFormalParameterElement extends Mock implements FormalParameterElement {
  MockFormalParameterElement._();

  factory MockFormalParameterElement({String? name, bool? isRequired, DartType? type}) {
    final mock = MockFormalParameterElement._();

    name = name ?? faker.lorem.word();
    isRequired = isRequired ?? faker.randomGenerator.boolean();
    type = type ?? MockDartType();

    when(() => mock.name).thenReturn(name);
    when(() => mock.isRequired).thenReturn(isRequired);
    when(() => mock.type).thenReturn(type);

    return mock;
  }
}
