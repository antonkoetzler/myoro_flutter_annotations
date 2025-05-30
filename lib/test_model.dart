import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';

part 'test_model.g.dart';

@myoroModel
class TestModel with $TestModel {
  final String name;
  final int? age;
  final bool isActive;

  const TestModel({required this.name, this.age, required this.isActive});
}
