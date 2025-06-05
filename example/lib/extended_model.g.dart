// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extended_model.dart';

// **************************************************************************
// MyoroModelGenerator
// **************************************************************************

extension $ExtendedModelExtension on ExtendedModel {
  ExtendedModel copyWith({
    int? foo,
    String? bar,
    bool barProvided = true,
    int? buzz,
    String? light,
    bool lightProvided = true,
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
/// class ExtendedModel with $ExtendedModelMixin {}
/// ```
mixin $ExtendedModelMixin {
  ExtendedModel get self => this as ExtendedModel;

  @override
  bool operator ==(Object other) {
    return other is ExtendedModel &&
        other.runtimeType == runtimeType &&
        other.foo == self.foo &&
        other.bar == self.bar &&
        other.buzz == self.buzz &&
        other.light == self.light;
  }

  @override
  int get hashCode {
    return Object.hash(self.foo, self.bar, self.buzz, self.light);
  }

  @override
  String toString() =>
      'ExtendedModel(\n'
      '  foo: ${self.foo},\n'
      '  bar: ${self.bar},\n'
      '  buzz: ${self.buzz},\n'
      '  light: ${self.light},\n'
      ');';
}
