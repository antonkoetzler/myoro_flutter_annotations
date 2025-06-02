// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// MyoroModelGenerator
// **************************************************************************

extension $TestModelExtension on TestModel {
  TestModel copyWith({String? foo, int? bar, bool barProvided = true}) {
    return TestModel(
      foo: foo ?? this.foo,
      bar: barProvided ? (bar ?? this.bar) : null,
    );
  }
}

/// Apply this mixin to [TestModel] once the code is generated.
///
/// ```dart
/// class TestModel with mixin $TestModelMixin { { ... }
/// ```
mixin $TestModelMixin {
  TestModel get self => this as TestModel;

  @override
  bool operator ==(Object other) {
    return other is TestModel &&
        other.runtimeType == runtimeType &&
        other.foo == self.foo &&
        other.bar == self.bar;
  }

  @override
  int get hashCode {
    return Object.hashAll([self.foo, self.bar]);
  }

  @override
  String toString() =>
      'TestModel(\n'
      '  foo: ${self.foo},\n'
      '  bar: ${self.bar},\n'
      ');';
}
