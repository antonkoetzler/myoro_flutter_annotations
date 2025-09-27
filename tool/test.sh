#!/bin/bash
#
# Script to format and fix the files.
dart pub global activate coverage
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.dart_tool/package_config.json --report-on=lib
genhtml coverage/lcov.info -o coverage/html
