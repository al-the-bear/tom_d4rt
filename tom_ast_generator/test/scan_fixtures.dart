/// Filesystem fixtures for tests that drive a `ToolRunner` with `--scan`.
///
/// Kept separate from `test_helpers.dart`, which owns the AST round-trip and
/// nothing else.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// Creates an empty temporary directory **inside the workspace**, for tests
/// that hand the path to `--scan`.
///
/// `ToolRunner` rejects a `--scan` path outside the workspace root
/// (tom_build_base 2.6.28): pointing a traversal at, say, `/tmp` used to scan
/// nothing and exit `0`, which made "wrong path" and "nothing to do"
/// indistinguishable. `Directory.systemTemp` is exactly such an outside path,
/// so it cannot be used for scan targets.
///
/// The directory is created under `.dart_tool/`, which is gitignored in every
/// package — a scan fixture must not be able to leave untracked files behind
/// and dirty the tree.
Future<Directory> createInWorkspaceTempDir(String prefix) async {
  final parent = Directory(p.join(Directory.current.path, '.dart_tool'));
  await parent.create(recursive: true);
  return parent.createTemp(prefix);
}
