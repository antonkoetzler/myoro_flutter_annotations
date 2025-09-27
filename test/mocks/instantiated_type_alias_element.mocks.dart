import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mocktail/mocktail.dart';

/// [InstantiatedTypeAliasElement] mock.
final class MockInstantiatedTypeAliasElement extends Mock implements InstantiatedTypeAliasElement {
  MockInstantiatedTypeAliasElement._();

  factory MockInstantiatedTypeAliasElement({required String name, List<DartType> typeArguments = const []}) {
    final mock = MockInstantiatedTypeAliasElement._();
    final element = MockTypeAliasElement();

    when(() => element.name).thenReturn(name);
    when(() => mock.element).thenReturn(element);
    when(() => mock.typeArguments).thenReturn(typeArguments);

    return mock;
  }
}

/// [TypeAliasElement] mock for TypeAlias element.
final class MockTypeAliasElement extends Mock implements TypeAliasElement {
  MockTypeAliasElement();
}
