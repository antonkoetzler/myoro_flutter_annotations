// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// MyoroModelGenerator
// **************************************************************************

extension $TestModelExtension on TestModel {
  TestModel copyWith({
    String? name,
    int? age,
    bool ageProvided = true,
    bool? isActive,
  }) {
    return TestModel(
      name: name ?? this.name,
      age: ageProvided ? (age ?? this.age) : null,
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Apply this mixin to TestModel once the code is generated.
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
        other.name == self.name &&
        other.age == self.age &&
        other.isActive == self.isActive;
  }

  @override
  int get hashCode {
    return Object.hash(
      self.name,
      self.age,
      self.isActive,
    );
  }

  @override
  String toString() => 'TestModel(\n'
      'name: $self.name,\n'
      'age: $self.age,\n'
      'isActive: $self.isActive,\n'
      ');';
}
