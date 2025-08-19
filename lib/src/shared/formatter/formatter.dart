// NOTE: Not tested.

import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';

/// The Dart formatter.
final formatter = DartFormatter(
  languageVersion: Version.parse(Platform.version.split(' ').first),
  trailingCommas: TrailingCommas.automate,
);
