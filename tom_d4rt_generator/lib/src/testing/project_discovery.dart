/// The directory walk shared by the project-discovery functions in
/// `testing.dart`. Not exported: callers want "projects under a root", and the
/// marker file is an implementation detail of each.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// Directories under [root] that contain a file named [marker] for which
/// [accept] holds, relative to [root] and sorted. `.dart_tool` and `build`
/// trees are skipped — judged relative to [root], so a root that itself lies
/// under a `.dart_tool` still finds its projects.
List<String> projectDirectoriesUnder(
  String root,
  String marker, {
  bool Function(File file)? accept,
}) {
  final directory = Directory(root);
  if (!directory.existsSync()) return const [];
  final projects = <String>[];
  for (final entity in directory.listSync(recursive: true)) {
    if (entity is! File || p.basename(entity.path) != marker) continue;
    final segments = p.split(p.relative(entity.path, from: root));
    if (segments.contains('.dart_tool') || segments.contains('build')) continue;
    if (accept != null && !accept(entity)) continue;
    projects.add(p.relative(entity.parent.path, from: root));
  }
  return projects..sort();
}
