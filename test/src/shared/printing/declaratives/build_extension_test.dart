import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../../mocks/class_element.mocks.dart';

void main() {
  test('buildExtension writes expected content and executes body', () {
    final buffer = StringBuffer();
    final element = MockClassElement();
    var bodyCalled = false;

    buildExtension(buffer, element, () {
      buffer.writeln('// body');
      bodyCalled = true;
    });

    final output = buffer.toString();

    expect(bodyCalled, isTrue);
    expect(output, contains('/// Extension class for @myoroModel'));
    expect(
      output,
      contains(
        'extension \$${element.name}Extension${element.formattedTypeParameters} on ${element.nameWithTypeParameters} {',
      ),
    );
    expect(output, contains('// body'));
    expect(output.trim().endsWith('}'), isTrue);
  });
}
