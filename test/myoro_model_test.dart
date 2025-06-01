import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:myoro_flutter_annotations/src/annotations/exports.dart';
import 'package:test/test.dart';

void main() {
  test('MyoroModel annotation generates code', () async {
    final sourceAssets = {
      // Main export file
      'myoro_flutter_annotations|lib/myoro_flutter_annotations.dart': '''
        export 'src/annotations/model/myoro_model.dart';
      ''',
      // Annotation definition
      'myoro_flutter_annotations|lib/src/annotations/model/myoro_model.dart': await File('lib/src/annotations/model/myoro_model.dart').readAsString(),
      // Test class file that uses the annotation
      'myoro_flutter_annotations|lib/src/my_class.dart': '''
        import 'package:myoro_flutter_annotations/src/annotations/model/myoro_model.dart';

        part 'my_class.myoro_model.g.dart';

        @myoroModel
        class MyClass {
          final String name;
          final int age;

          const MyClass({
            required this.name,
            required this.age,
          });
        }
        ''',
    };

    final expectedOutput = {
      // myoro_model.g.part file is a list of bytes.
      'myoro_flutter_annotations|lib/src/my_class.myoro_model.g.part': decodedMatches(contains('copyWith')),
    };

    final result = await testBuilder(
      myoroModelBuilder(BuilderOptions({})),
      sourceAssets,
      outputs: expectedOutput,
      reader: InMemoryAssetReader(),
    );
  });

  // test('MyoroModel annotation on non-class throws error', () async {
  //   final sourceAssets = {
  //     'my_package|lib/src/exports.dart': myoroAnnotationSource,
  //     'my_package|lib/src/my_variable.dart': '''
  //       import 'package:myoro_flutter_annotations/src/exports.dart';

  //       @myoroModel
  //       const myVariable = 42;
  //     ''',
  //   };

  //   await expectLater(
  //     () => testBuilder(
  //       myoroModelBuilder(BuilderOptions({})),
  //       sourceAssets,
  //       reader: InMemoryAssetReader(),
  //     ),
  //     throwsA(isA<UnresolvedAnnotationException>()),
  //   );
  // });
}
