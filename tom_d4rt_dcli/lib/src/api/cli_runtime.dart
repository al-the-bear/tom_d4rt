// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// CLI Runtime - Process and platform runtime information.
///
/// This file provides access to system-level information that is distinct
/// from the CLI's virtual working directory. While `cli.cwd()` returns the
/// CLI's navigated directory, `cli.runtime` provides access to the actual
/// process directory and platform information.
library;

import 'dart:io' as io;

// =============================================================================
// CliRuntime Interface
// =============================================================================

/// Provides access to process and platform runtime information.
///
/// This exposes system-level information that is distinct from the CLI's
/// virtual working directory (`cwd`). While `cli.cwd()` returns the CLI's
/// navigated directory, `cli.runtime.processDirectory` returns the actual
/// process working directory (`Directory.current`).
///
/// Example:
/// ```dart
/// // CLI's virtual working directory
/// print(cli.cwd());  // '/project' (navigated with cd)
///
/// // Actual process directory
/// print(cli.runtime.processDirectory);  // '/home/user' (process cwd)
///
/// // Platform information
/// print(cli.runtime.operatingSystem);  // 'macos'
/// print(cli.runtime.pid);  // 12345
/// ```
abstract class CliRuntime {
  /// The actual process working directory (`Directory.current.path`).
  ///
  /// Unlike `cli.cwd()`, this reflects the real process directory.
  /// Changing this affects the actual process, not just CLI path resolution.
  String get processDirectory;

  /// Set the actual process working directory (`Directory.current`).
  ///
  /// Warning: This affects the entire process, not just CLI navigation.
  set processDirectory(String path);

  /// The Directory object for the current process directory.
  io.Directory get processDirectoryObject;

  /// The process ID of the current Dart VM.
  int get pid;

  /// Path to the Dart executable running this process.
  String get executable;

  /// The resolved path to the Dart executable.
  String get resolvedExecutable;

  /// Arguments passed to the executable.
  List<String> get executableArguments;

  /// The script URI being executed.
  Uri get script;

  /// The Dart version string.
  String get version;

  /// Environment variables as a map.
  Map<String, String> get environment;

  /// Operating system name (e.g., 'linux', 'macos', 'windows').
  String get operatingSystem;

  /// Operating system version.
  String get operatingSystemVersion;

  /// Number of processors available.
  int get numberOfProcessors;

  /// Local hostname.
  String get localHostname;

  /// Path separator for the current platform ('/' or '\').
  String get pathSeparator;

  /// Whether running on Linux.
  bool get isLinux;

  /// Whether running on macOS.
  bool get isMacOS;

  /// Whether running on Windows.
  bool get isWindows;

  /// Whether running on Android.
  bool get isAndroid;

  /// Whether running on iOS.
  bool get isIOS;
}

// =============================================================================
// CliRuntimeImpl - Default Implementation
// =============================================================================

/// Default implementation of [CliRuntime] using dart:io Platform and Directory.
class CliRuntimeImpl implements CliRuntime {
  /// Creates a runtime implementation.
  CliRuntimeImpl();

  @override
  String get processDirectory => io.Directory.current.path;

  @override
  set processDirectory(String path) {
    io.Directory.current = io.Directory(path);
  }

  @override
  io.Directory get processDirectoryObject => io.Directory.current;

  @override
  int get pid => io.pid;

  @override
  String get executable => io.Platform.executable;

  @override
  String get resolvedExecutable => io.Platform.resolvedExecutable;

  @override
  List<String> get executableArguments => io.Platform.executableArguments;

  @override
  Uri get script => io.Platform.script;

  @override
  String get version => io.Platform.version;

  @override
  Map<String, String> get environment => io.Platform.environment;

  @override
  String get operatingSystem => io.Platform.operatingSystem;

  @override
  String get operatingSystemVersion => io.Platform.operatingSystemVersion;

  @override
  int get numberOfProcessors => io.Platform.numberOfProcessors;

  @override
  String get localHostname => io.Platform.localHostname;

  @override
  String get pathSeparator => io.Platform.pathSeparator;

  @override
  bool get isLinux => io.Platform.isLinux;

  @override
  bool get isMacOS => io.Platform.isMacOS;

  @override
  bool get isWindows => io.Platform.isWindows;

  @override
  bool get isAndroid => io.Platform.isAndroid;

  @override
  bool get isIOS => io.Platform.isIOS;
}
