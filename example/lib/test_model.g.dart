// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// MyoroModelGenerator
// **************************************************************************

/// Apply this mixin to [TestModel] once the code is generated.
///
/// ```dart
/// class TestModel with _$TestModelMixin {}
/// ```
mixin _$TestModelMixin {
  TestModel get self => this as TestModel;

  TestModel copyWith({String? foo, int? bar, bool barProvided = true}) {
    return TestModel(foo: foo ?? self.foo, bar: barProvided ? (bar ?? self.bar) : null);
  }

  @override
  bool operator ==(Object other) {
    return other is TestModel && other.runtimeType == runtimeType && other.foo == self.foo && other.bar == self.bar;
  }

  @override
  int get hashCode {
    return Object.hash(self.foo, self.bar);
  }

  @override
  String toString() =>
      'TestModel(\n'
      '  foo: ${self.foo},\n'
      '  bar: ${self.bar},\n'
      ');';
}
