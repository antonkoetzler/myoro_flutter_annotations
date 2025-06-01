import 'package:build/build.dart';
import 'package:myoro_flutter_annotations/myoro_flutter_annotations.dart';
import 'package:source_gen/source_gen.dart';

/// Builder of [MyoroModel].
Builder myoroModelBuilder(BuilderOptions options) {
  return SharedPartBuilder(const [MyoroModelGenerator()], 'myoro_model');
}
