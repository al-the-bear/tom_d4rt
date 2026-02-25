// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Export barrel for D4rt CLI API.
///
/// This barrel exports all types needed for the `cli` global variable
/// and is used by the bridge generator.
///
/// Usage:
/// ```dart
/// import 'package:tom_dcli_exec/tom_d4rt_cli_api.dart';
///
/// void main() async {
///   cli.cd('/project');
///   await cli.replay('setup.d4rt');
///   final classes = cli.classes();
/// }
/// ```
library;

export 'src/api/cli_api.dart';
export 'src/api/cli_bridge.dart';
export 'src/api/cli_controller.dart';
export 'src/api/cli_exceptions.dart';
export 'src/api/cli_result_types.dart';
export 'src/api/cli_runtime.dart';
export 'src/api/cli_state.dart';
export 'src/api/cli_test_utils.dart';
export 'src/api/execution_context.dart';
