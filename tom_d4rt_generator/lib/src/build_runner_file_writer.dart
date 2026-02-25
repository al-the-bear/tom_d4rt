// Copyright (c) 2024. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Build_runner adapter for [FileWriter].
///
/// This writes files directly to the source tree, which is the appropriate
/// approach when using `build_to: source` in build.yaml.
library;

import 'dart:io';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;

import 'file_writer.dart';

/// Writes files directly to the source tree for build_runner.
///
/// Since we use `build_to: source`, we write generated files directly
/// to the filesystem rather than through BuildStep.writeAsString().
class BuildRunnerFileWriter implements FileWriter {
  // ignore: unused_field
  final BuildStep _buildStep;
  // ignore: unused_field
  final String _packageName;

  /// Creates an adapter wrapping the build_runner [buildStep].
  BuildRunnerFileWriter(this._buildStep, this._packageName);

  @override
  Future<void> writeFile(FileId fileId, String content) async {
    // Write directly to the source tree
    final file = File(fileId.path);
    await ensureDirectory(p.dirname(fileId.path));
    await file.writeAsString(content);
    log.fine('Wrote ${fileId.path}');
  }

  @override
  Future<void> ensureDirectory(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  @override
  String absolutePath(FileId fileId) {
    return p.absolute(fileId.path);
  }
}

/// Extension to convert between build_runner's AssetId and FileId.
extension AssetIdToFileIdExtension on AssetId {
  /// Converts this AssetId to a FileId.
  FileId toFileId() => FileId(package, path);
}

/// Extension to convert FileId to build_runner's AssetId.
extension FileIdToAssetIdExtension on FileId {
  /// Converts this FileId to an AssetId.
  AssetId toAssetId() => AssetId(package, path);
}
