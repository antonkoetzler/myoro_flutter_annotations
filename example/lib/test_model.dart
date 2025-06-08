import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';

part 'test_model.g.dart';

@myoroModel
final class TestModel with _$TestModelMixin {
  final String foo;
  final int? bar;

  const TestModel({required this.foo, this.bar});
}
