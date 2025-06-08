import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

final _baseAssets = {
  'myoro_flutter_annotations|lib/myoro_flutter_annotations.dart': '''
    export 'src/annotations/theme_extension/myoro_theme_extension.dart';
  ''',
  'myoro_flutter_annotations|lib/src/annotations/theme_extension/myoro_theme_extension.dart': File(
    'lib/src/annotations/theme_extension/myoro_theme_extension.dart',
  ).readAsStringSync(),
};

void main() {
  test('MyoroThemeExtensionBuilder success case', () async {
    final sourceAssets = {
      ..._baseAssets,
      'myoro_flutter_annotations|lib/src/foo_theme_extension.dart': '''
        import 'package:myoro_flutter_annotations/src/annotations/theme_extension/myoro_theme_extension.dart';

        part 'foo_theme_extension.myoro_theme_extension.g.dart';

        @myoroThemeExtension
        class FooThemeExtension extends ThemeExtension<FooThemeExtension> with _\$FooThemeExtensionMixin {
          final dynamic foo;

          const FooThemeExtension({this.foo});
        }
        ''',
    };

    final expectedOutput = {
      'myoro_flutter_annotations|lib/src/foo_theme_extension.myoro_theme_extension.g.part': decodedMatches(
        allOf([
          contains('FooThemeExtension copyWith({'),
          contains('mixin _\$FooThemeExtensionMixin'),
          contains('bool operator ==(Object other)'),
          contains('int get hashCode'),
        ]),
      ),
    };

    await testBuilder(
      myoroThemeExtensionBuilder(BuilderOptions({})),
      sourceAssets,
      outputs: expectedOutput,
      reader: InMemoryAssetReader(),
    );
  });

  test('MyoroThemeExtension annotation throws error on non-class elements', () async {
    final sourceAssets = {
      ..._baseAssets,
      'myoro_flutter_annotations|lib/src/my_function.dart': '''
        import 'package:myoro_flutter_annotations/src/annotations/theme_extension/myoro_theme_extension.dart';
        
        @myoroThemeExtension
        void foo() {}
      ''',
    };

    expectLater(
      () async => await testBuilder(myoroThemeExtensionBuilder(BuilderOptions({})), sourceAssets),
      throwsA(isA<InvalidGenerationSourceError>()),
    );
  });
}
