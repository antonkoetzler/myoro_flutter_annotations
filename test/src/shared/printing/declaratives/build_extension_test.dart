import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../../mocks/class_element.mocks.dart';

void main() {
  test('buildExtension', () {
    const bodyText = 'Hello, World!';

    final buffer = StringBuffer();
    final element = MockClassElement();
    final formattedTypeParameters = element.formattedTypeParameters;

    buildExtension(buffer, element, () => buffer.writeln(bodyText));

    expect(buffer.toString(), '''
extension \$${element.name}Extension$formattedTypeParameters on ${element.name}$formattedTypeParameters {
$bodyText
}
''');
  });
}
