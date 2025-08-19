import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:mocktail/mocktail.dart';

/// [ConstructorElement] mock.
final class MockConstructorElement2 extends Mock implements ConstructorElement2 {
  MockConstructorElement2._();

  factory MockConstructorElement2({List<FormalParameterElement> parameters = const []}) {
    final mock = MockConstructorElement2._();

    when(() => mock.formalParameters).thenReturn(parameters);

    return mock;
  }
}
