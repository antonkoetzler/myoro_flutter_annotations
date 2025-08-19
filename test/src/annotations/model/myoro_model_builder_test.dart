import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:myoro_flutter_annotations/src/annotations/exports.dart';
import 'package:test/test.dart';

final _baseAssets = {
  'myoro_flutter_annotations|lib/myoro_flutter_annotations.dart': '''
    export 'src/annotations/model/myoro_model.dart';
  ''',
  'myoro_flutter_annotations|lib/src/annotations/model/myoro_model.dart': File(
    'lib/src/annotations/model/myoro_model.dart',
  ).readAsStringSync(),
};

void main() {
  test('MyoroModelBuilder success case', () async {
    final sourceAssets = {
      ..._baseAssets,
      'myoro_flutter_annotations|lib/src/foo.dart': '''
        import 'package:myoro_flutter_annotations/src/annotations/model/myoro_model.dart';

        part 'foo.myoro_model.g.dart';

        @myoroModel
        class Foo with _\$FooMixin {
          final dynamic foo;

          const Foo({this.foo});
        }
        ''',
    };

    final expectedOutput = {
      'myoro_flutter_annotations|lib/src/foo.myoro_model.g.part': decodedMatches(
        allOf([
          contains('mixin _\$FooMixin'),
          contains('bool operator ==(Object other)'),
          contains('int get hashCode'),
        ]),
      ),
    };

    await testBuilder(myoroModelBuilder(BuilderOptions({})), sourceAssets, outputs: expectedOutput);
  });

  test('MyoroModel annotation throws error on non-class elements', () async {
    final sourceAssets = {
      ..._baseAssets,
      'myoro_flutter_annotations|lib/src/my_function.dart': '''
        import 'package:myoro_flutter_annotations/src/annotations/model/myoro_model.dart';

        @myoroModel
        void foo() {}
      ''',
    };

    bool errorTriggered = false;
    const errorMessage =
        '[MyoroModelGenerator.generateForAnnotatedElement]: MyoroModel can only be applied to classes.';

    await testBuilder(
      myoroModelBuilder(BuilderOptions({})),
      sourceAssets,
      onLog: (logRecord) {
        if (errorTriggered) return;
        errorTriggered = logRecord.level == Level.SEVERE && logRecord.message.contains(errorMessage);
      },
    );

    expect(errorTriggered, isTrue);
  });
}
