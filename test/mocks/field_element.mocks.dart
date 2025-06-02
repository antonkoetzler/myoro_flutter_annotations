import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'dart_type.mocks.dart';

/// [FieldElement] mock.
final class MockFieldElement extends Mock implements FieldElement {
  MockFieldElement._();

  factory MockFieldElement({String? name, DartType? type, bool isStatic = false, bool isSynthetic = false}) {
    final mock = MockFieldElement._();

    final effectiveType = type ?? MockDartType();
    registerFallbackValue(effectiveType);

    when(() => mock.name).thenReturn(name ?? faker.lorem.word());
    when(() => mock.type).thenReturn(effectiveType);
    when(() => mock.isStatic).thenReturn(isStatic);
    when(() => mock.isSynthetic).thenReturn(isSynthetic);

    return mock;
  }
}
