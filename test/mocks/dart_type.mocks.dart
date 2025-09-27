import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

/// [DartType] mock.
final class MockDartType extends Mock implements DartType {
  MockDartType._();

  factory MockDartType({
    String? displayString,
    NullabilitySuffix nullabilitySuffix = NullabilitySuffix.none,
    InstantiatedTypeAliasElement? alias,
  }) {
    final mock = MockDartType._();

    when(() => mock.getDisplayString()).thenReturn(displayString ?? faker.lorem.word());
    when(() => mock.name).thenReturn(faker.lorem.word());
    when(() => mock.nullabilitySuffix).thenReturn(nullabilitySuffix);
    when(() => mock.alias).thenReturn(alias);

    return mock;
  }
}
