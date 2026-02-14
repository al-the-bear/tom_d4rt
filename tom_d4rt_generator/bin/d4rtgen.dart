#!/usr/bin/env dart
/// D4rt Bridge Generator CLI (d4rtgen)
///
/// Command-line interface for generating D4rt bridges from configuration files.
/// Configuration is read from buildkit.yaml (d4rtgen: section).
/// Run `d4rtgen help` or `--help` for full usage information.
library;

import 'dart:io';

import 'package:tom_build_base/tom_build_base_v2.dart';

import 'package:tom_d4rt_generator/src/v2/d4rtgen_tool.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_executor.dart';

void main(List<String> args) async {
  final runner = ToolRunner(
    tool: d4rtgenTool,
    executors: createD4rtgenExecutors(),
  );

  final result = await runner.run(args);

  if (!result.success) {
    exitCode = 1;
  }
}
