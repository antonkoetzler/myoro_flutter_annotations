import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../mocks/class_element.mocks.dart';

void main() {
  const bodyText = 'Hello, World!';

  final buffer = StringBuffer();
  final classElement = MockClassElement();

  void testMixin([String? onClass]) {
    buildMixin(buffer..clear(), classElement, () => buffer.writeln(bodyText), onClass: onClass);
    final mixinResult = buffer.toString();

    buffer
      ..clear()
      ..writeln('/// Apply this mixin to [${classElement.name}] once the code is generated.')
      ..writeln('///')
      ..writeln('/// ```dart')
      ..writeln('/// class ${classElement.name} with \$${classElement.name}Mixin { ... }')
      ..writeln('/// ```')
      ..writeln('mixin \$${classElement.name}Mixin ${onClass != null ? 'on $onClass ' : ''}{')
      ..writeln('${classElement.name} get self => this as ${classElement.name};\n')
      ..writeln(bodyText)
      ..writeln('}');

    expect(mixinResult, buffer.toString());
  }

  test('buildMixin without onClass provided', () => testMixin());

  test('buildMixin with onClass provided', () => testMixin(faker.lorem.word()));
}
