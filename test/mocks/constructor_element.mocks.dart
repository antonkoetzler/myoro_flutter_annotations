import 'package:analyzer/dart/element/element.dart';
import 'package:mocktail/mocktail.dart';

/// [ConstructorElement] mock.
final class MockConstructorElement extends Mock implements ConstructorElement {
  MockConstructorElement._();

  factory MockConstructorElement({List<ParameterElement> parameters = const []}) {
    final mock = MockConstructorElement._();

    when(() => mock.parameters).thenReturn(parameters);

    return mock;
  }
}
