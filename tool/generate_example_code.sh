#!/bin/bash
#
# Script to run the build_runner for the example classes.
cd example
dart run build_runner build --delete-conflicting-outputs
cd ..
bash tool/format_and_fix.sh
