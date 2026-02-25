// Copyright (c) 2024. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Abstraction layer for file writing in the D4rt bridge generator.
///
/// This allows the bridge generator to work with both:
/// - Direct file system writes (for CLI usage)
/// - build_runner's BuildStep (for integration with build system)
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// Represents a file identifier with package name and path.
///
/// This is an abstraction over build_runner's AssetId that can work
/// standalone without the build package dependency.
class FileId {
  /// The package name containing this file.
  final String package;

  /// The path within the package (e.g., 'lib/src/bridges/foo_bridge.dart').
  final String path;

  /// Creates a file identifier.
  const FileId(this.package, this.path);

  /// Creates a new FileId with a different path but same package.
  FileId withPath(String newPath) => FileId(package, newPath);

  @override
  String toString() => '$package|$path';

  @override
  bool operator ==(Object other) =>
      other is FileId && other.package == package && other.path == path;

  @override
  int get hashCode => Object.hash(package, path);
}

/// Abstract interface for writing output files.
///
/// Implementations provide file writing capability for different
/// execution contexts (CLI vs build_runner).
abstract class FileWriter {
  /// Writes content to a file.
  ///
  /// The [fileId] identifies the output file location.
  /// The [content] is the text to write.
  Future<void> writeFile(FileId fileId, String content);

  /// Creates a directory if it doesn't exist.
  ///
  /// The [path] is the absolute path to the directory.
  Future<void> ensureDirectory(String path);

  /// Gets the absolute path for a file.
  ///
  /// For standalone use, this converts relative paths to absolute.
  /// For build_runner, this may be used for logging.
  String absolutePath(FileId fileId);
}

/// Standalone [FileWriter] implementation using direct file system access.
///
/// This is used for CLI tools that don't run through build_runner.
class StandaloneFileWriter implements FileWriter {
  /// The root directory for file operations.
  final String projectRoot;

  /// Creates a standalone file writer rooted at [projectRoot].
  StandaloneFileWriter(this.projectRoot);

  @override
  Future<void> writeFile(FileId fileId, String content) async {
    final path = absolutePath(fileId);
    final file = File(path);
    
    // Ensure parent directory exists
    final parentDir = file.parent;
    if (!parentDir.existsSync()) {
      await parentDir.create(recursive: true);
    }
    
    await file.writeAsString(content);
  }

  @override
  Future<void> ensureDirectory(String path) async {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
  }

  @override
  String absolutePath(FileId fileId) {
    return p.join(projectRoot, fileId.path);
  }
}
