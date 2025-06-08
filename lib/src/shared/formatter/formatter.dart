// NOTE: Not tested.

import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';

/// The Dart formatter.
final formatter = DartFormatter(languageVersion: Version(3, 8, 1), trailingCommas: TrailingCommas.automate);
