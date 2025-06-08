// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_model.dart';

// **************************************************************************
// MyoroModelGenerator
// **************************************************************************

extension _$GenericModelExtension<T> on GenericModel<T> {
  // ignore: unused_element
  GenericModel<T> copyWith({T? foo, int? bar, bool barProvided = true}) {
    return GenericModel(foo: foo ?? this.foo, bar: barProvided ? (bar ?? this.bar) : null);
  }
}

/// Apply this mixin to [GenericModel] once the code is generated.
///
/// ```dart
/// class GenericModel<T> with _$GenericModelMixin<T> {}
/// ```
mixin _$GenericModelMixin<T> {
  GenericModel<T> get self => this as GenericModel<T>;

  @override
  bool operator ==(Object other) {
    return other is GenericModel<T> &&
        other.runtimeType == runtimeType &&
        other.foo == self.foo &&
        other.bar == self.bar;
  }

  @override
  int get hashCode {
    return Object.hash(self.foo, self.bar);
  }

  @override
  String toString() =>
      'GenericModel<T>(\n'
      '  foo: ${self.foo},\n'
      '  bar: ${self.bar},\n'
      ');';
}
