// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extended_model.dart';

// **************************************************************************
// MyoroModelGenerator
// **************************************************************************

extension _$ExtendedModelExtension on ExtendedModel {
  // ignore: unused_element
  ExtendedModel copyWith({
    int? buzz,
    String? light,
    bool lightProvided = true,
    int? foo,
    String? bar,
    bool barProvided = true,
  }) {
    return ExtendedModel(
      foo: foo ?? this.foo,
      bar: barProvided ? (bar ?? this.bar) : null,
      buzz: buzz ?? this.buzz,
      light: lightProvided ? (light ?? this.light) : null,
    );
  }
}

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
