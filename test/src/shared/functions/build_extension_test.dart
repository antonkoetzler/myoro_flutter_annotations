import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../mocks/class_element.mocks.dart';

void main() {
  test('buildExtension', () {
    const bodyText = 'Hello, World!';

    final buffer = StringBuffer();
    final classElement = MockClassElement();

    buildExtension(buffer, classElement, () => buffer.writeln(bodyText));

    expect(buffer.toString(), '''
extension \$${classElement.name}Extension on ${classElement.name} {
$bodyText
}
''');
  });
}
