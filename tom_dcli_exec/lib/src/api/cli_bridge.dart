// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// D4rt CLI Bridge Registration.
///
/// This file provides the bridge registration for the `cli` global variable,
/// making the CLI API accessible from D4rt scripts.
library;

import 'package:tom_d4rt_exec/tom_d4rt_exec.dart';

import 'cli_controller.dart';

/// The library URI for CLI API exports.
const cliLibrary = 'package:tom_dcli_exec/tom_d4rt_cli_api.dart';

/// Global holder for the CLI controller.
///
/// This is initialized by the REPL and accessed by scripts via the `cli` global.
final CliGlobalHolder cliGlobalHolder = CliGlobalHolder();

/// Registers the `cli` global variable with D4rt.
///
/// Call this during bridge registration, before the REPL starts.
/// The [cliGlobalHolder] must be initialized later when the controller is ready.
///
/// Example:
/// ```dart
/// void registerBridges(D4rt d4rt) {
///   registerCliBridge(d4rt);
///   // ... other bridges
/// }
///
/// void onReplStartup(D4rt d4rt, ReplState state) {
///   cliGlobalHolder.initialize(myCliController);
/// }
/// ```
void registerCliBridge(D4rt d4rt) {
  // Use registerGlobalGetter since the controller is initialized after registration
  d4rt.registerGlobalGetter(
    'cli',
    () => cliGlobalHolder.controller,
    cliLibrary,
  );
}

/// Registers the CLI API methods as global functions for convenience.
///
/// This provides shortcuts like `cwd()`, `cd()`, `ls()` at the top level
/// in addition to `cli.cwd()`, `cli.cd()`, etc.
///
/// Only register these if you want the shortcut functions available.
void registerCliShortcuts(D4rt d4rt) {
  // Directory shortcuts using the proper NativeFunctionImpl signature
  d4rt.registertopLevelFunction(
    'cwd',
    (visitor, args, namedArgs, typeArgs) => cliGlobalHolder.controller.cwd(),
    cliLibrary,
  );

  d4rt.registertopLevelFunction(
    'home',
    (visitor, args, namedArgs, typeArgs) => cliGlobalHolder.controller.home(),
    cliLibrary,
  );
}
