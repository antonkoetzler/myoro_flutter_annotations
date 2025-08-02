import 'package:flutter/foundation.dart';
import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';

part 'abstract_model.dart';
part 'extended_model.g.dart';

@immutable
@myoroModel
final class ExtendedModel extends AbstractModel with _$ExtendedModelMixin {
  const ExtendedModel({required super.foo, super.bar, required this.buzz, this.light});

  final int buzz;
  final String? light;
}
