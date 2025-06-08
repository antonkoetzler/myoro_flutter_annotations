import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(r'''
extension _$FooExtension on Foo {
  // ignore: unused_element
  Foo copyWith({int? bar, String? baz, bool bazProvided = true}) {
    return Foo(
      bar: bar ?? this.bar,
      baz: bazProvided ? (baz ?? this.baz) : null,
    );
  }
}

/// Apply this mixin to [Foo] once the code is generated.
///
/// ```dart
/// class Foo with _$FooMixin {}
/// ```
mixin _$FooMixin {
  Foo get self => this as Foo;

  @override
  bool operator ==(Object other) {
    return other is Foo &&
        other.runtimeType == runtimeType &&
        other.bar == self.bar &&
        other.baz == self.baz;
  }

  @override
  int get hashCode {
    return Object.hash(self.bar, self.baz);
  }

  @override
  String toString() =>
      'Foo(\n'
      '  bar: ${self.bar},\n'
      '  baz: ${self.baz},\n'
      ');';
}
''')
@myoroModel
class Foo {
  const Foo({required this.bar, this.baz});

  final int bar;
  final String? baz;
}

Future<void> main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
    'test/src/annotations/model',
    'myoro_model_generator_test.dart',
  );
  testAnnotatedElements<MyoroModel>(reader, MyoroModelGenerator());
}
