// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extended_model.dart';

// **************************************************************************
// MyoroModelGenerator
// **************************************************************************

// coverage:ignore-file

/// Apply this mixin to [ExtendedModel] once the code is generated.
///
/// ```dart
/// class ExtendedModel with _$ExtendedModelMixin {}
/// ```
mixin _$ExtendedModelMixin {
  ExtendedModel get self => this as ExtendedModel;

  @override
  bool operator ==(Object other) {
    return other is ExtendedModel &&
        other.runtimeType == runtimeType &&
        other.buzz == self.buzz &&
        other.light == self.light &&
        other.foo == self.foo &&
        other.bar == self.bar;
  }

  @override
  int get hashCode {
    return Object.hash(self.buzz, self.light, self.foo, self.bar);
  }

  @override
  String toString() =>
      'ExtendedModel(\n'
      '  buzz: ${self.buzz},\n'
      '  light: ${self.light},\n'
      '  foo: ${self.foo},\n'
      '  bar: ${self.bar},\n'
      ');';
}
