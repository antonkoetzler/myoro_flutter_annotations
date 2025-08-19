import 'package:faker/faker.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:test/test.dart';

import '../../../../mocks/class_element_2.mocks.dart';

void main() {
  const bodyText = 'Hello, World!';

  final buffer = StringBuffer();
  final element = MockClassElement2();
  final mixinName = '_\$${element.name3}Mixin${element.formattedTypeParameters}';

  void testMixin([String? onClass]) {
    buildMixin(buffer..clear(), element, () => buffer.writeln(bodyText), onClass: onClass);
    final mixinResult = buffer.toString();

    buffer
      ..clear()
      ..writeln('/// Apply this mixin to [${element.name3}] once the code is generated.')
      ..writeln('///')
      ..writeln('/// ```dart')
      ..writeln('/// class ${element.nameWithTypeParameters} with $mixinName {}')
      ..writeln('/// ```')
      ..writeln('mixin $mixinName ${onClass != null ? 'on $onClass ' : ''}{')
      ..writeln('${element.nameWithTypeParameters} get self => this as ${element.nameWithTypeParameters};\n')
      ..writeln(bodyText)
      ..writeln('}');

    expect(mixinResult, buffer.toString());
  }

  test('buildMixin without onClass provided', () => testMixin());

  test('buildMixin with onClass provided', () => testMixin(faker.lorem.word()));
}
