import 'package:build/build.dart';
import 'package:myoro_flutter_annotations/src/exports.dart';
import 'package:source_gen/source_gen.dart';

/// Builder of [MyoroModel].
Builder myoroModelBuilder(BuilderOptions options) {
  return SharedPartBuilder(const [MyoroModelGenerator()], 'myoro_model');
}
