#!/usr/bin/env dart
/// AST Generator CLI (astgen)
///
/// Command-line interface for converting Dart source files to serialized
/// AST YAML files.  Configuration is read from buildkit.yaml (astgen: section).
/// Run `astgen help` or `--help` for full usage information.
library;

import 'dart:io';

import 'package:tom_build_base/tom_build_base_v2.dart';

import 'package:tom_ast_generator/src/v2/astgen_tool.dart';
import 'package:tom_ast_generator/src/v2/astgen_executor.dart';

void main(List<String> args) async {
  final runner = ToolRunner(
    tool: astgenTool,
    executors: createAstgenExecutors(),
  );

  final result = await runner.run(args);

  if (!result.success) {
    exitCode = 1;
  }
}
