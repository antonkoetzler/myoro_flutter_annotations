import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../mocks/class_element.mocks.dart';

void main() {
  const bodyText = 'Hello, World!';

  final buffer = StringBuffer();
  final element = MockClassElement();

  void testMixin([String? onClass]) {
    buildMixin(buffer..clear(), element, () => buffer.writeln(bodyText), onClass: onClass);
    final mixinResult = buffer.toString();

    buffer
      ..clear()
      ..writeln('/// Apply this mixin to [${element.name}] once the code is generated.')
      ..writeln('///')
      ..writeln('/// ```dart')
      ..writeln('/// class ${element.name} with \$${element.name}Mixin {}')
      ..writeln('/// ```')
      ..writeln('mixin \$${element.name}Mixin ${onClass != null ? 'on $onClass ' : ''}{')
      ..writeln('${element.name} get self => this as ${element.name};\n')
      ..writeln(bodyText)
      ..writeln('}');

    expect(mixinResult, buffer.toString());
  }

  test('buildMixin without onClass provided', () => testMixin());

  test('buildMixin with onClass provided', () => testMixin(faker.lorem.word()));
}
