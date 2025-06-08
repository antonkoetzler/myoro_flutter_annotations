import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';

part 'generic_model.g.dart';

@myoroModel
final class GenericModel<T> with _$GenericModelMixin<T> {
  final T foo;
  final int? bar;

  const GenericModel({required this.foo, this.bar});
}
