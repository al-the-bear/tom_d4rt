// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// D4rt CLI Integration for ReplBase.
///
/// This file provides integration between the new CLI API and the existing
/// D4rtReplBase REPL infrastructure.
library;

import 'package:tom_d4rt/tom_d4rt.dart';

import '../api/cli_bridge.dart';
import '../api/cli_controller.dart';
import '../api/cli_state.dart';
import 'repl_state.dart';

/// Integrates the CLI API with the existing REPL infrastructure.
///
/// This class bridges the gap between the new Console-independent CLI API
/// and the existing Console-dependent ReplState.
///
/// Usage:
/// ```dart
/// class MyRepl extends D4rtReplBase {
///   final _cliIntegration = CliReplIntegration();
///
///   @override
///   void registerBridges(D4rt d4rt) {
///     super.registerBridges(d4rt);
///     _cliIntegration.registerBridge(d4rt);
///   }
///
///   @override
///   Future<void> onReplStartup(D4rt d4rt, ReplState state) async {
///     _cliIntegration.initialize(d4rt, state, toolName: toolName);
///   }
/// }
/// ```
class CliReplIntegration {
  D4rtCliController? _controller;

  /// Gets the controller, if initialized.
  D4rtCliController? get controller => _controller;

  /// Registers the CLI bridge with D4rt.
  ///
  /// Call this from `registerBridges` before the REPL starts.
  void registerBridge(D4rt d4rt) {
    registerCliBridge(d4rt);
  }

  /// Initializes the CLI controller with the D4rt instance and ReplState.
  ///
  /// Call this from `onReplStartup` after the REPL has initialized.
  void initialize(
    D4rt d4rt,
    ReplState state, {
    required String toolName,
  }) {
    // Create CliState that wraps the ReplState
    final cliState = _createCliState(state);

    // Create the controller
    _controller = D4rtCliController(
      d4rt: d4rt,
      state: cliState,
      toolName: toolName,
    );

    // Initialize the global holder
    cliGlobalHolder.initialize(_controller!);
  }

  /// Creates a CliState from a ReplState.
  CliState _createCliState(ReplState replState) {
    return CliState(
      dataDirectory: replState.dataDirectory,
      initialDirectory: replState.currentDirectory,
    );
  }
}
