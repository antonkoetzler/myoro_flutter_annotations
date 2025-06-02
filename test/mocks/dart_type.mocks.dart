import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

/// [DartType] mock.
final class MockDartType extends Mock implements DartType {
  MockDartType._();

  factory MockDartType({NullabilitySuffix nullabilitySuffix = NullabilitySuffix.none}) {
    final mock = MockDartType._();

    when(() => mock.name).thenReturn(faker.lorem.word());
    when(() => mock.nullabilitySuffix).thenReturn(nullabilitySuffix);

    return mock;
  }
}
