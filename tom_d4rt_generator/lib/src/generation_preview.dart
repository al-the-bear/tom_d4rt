/// What running bridge generation against a package would write — measured by
/// running it, with every write sent to a scratch tree that is then discarded.
///
/// Two callers need this answer and must agree on it: `d4rtgen --dry-run`,
/// which reports it, and `checkBridgeFreshness`, which asserts on it. Both run
/// the real generation code rather than a model of it, inside the overlay in
/// `scratch_overlay.dart`, so every writer the generator has — module bridges,
/// relaxers, proxies, barrel, dartscript, test runner — is covered without any
/// of them knowing it is being previewed. They all write `*.b.dart` files,
/// because every destination passes through `ensureBDartExtension`; that
/// suffix is what the overlay redirects.
///
/// WHAT IS NOT COVERED. The overlay sees `dart:io` [File] and [Directory]
/// only. A subprocess would escape it — which is why `checkBridgeFreshness`
/// refuses an unresolved package rather than let `generateBridges` run
/// `dart pub get` — and so would a write to a file that does not end in
/// `.b.dart`. The analyzer summary cache the generator fills lives in the tool
/// cache, outside the package, and is written as usual: it is a cache, and a
/// preview that leaves it warm changes nothing the package tracks.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

import 'scratch_overlay.dart';

/// How a previewed write relates to the file already in the package.
enum PreviewedChange {
  /// The package has no such file.
  created('would create'),

  /// The package has the file, and its content differs beyond the
  /// `// Generated:` line.
  changed('would change'),

  /// The package has the file with the same content, apart from the
  /// `// Generated:` line.
  unchanged('unchanged');

  const PreviewedChange(this.label);

  /// How a report should describe the change.
  final String label;
}

/// One file a previewed run wrote.
class PreviewedWrite {
  /// Creates a record of a write to [path].
  const PreviewedWrite(this.path, this.change);

  /// Package-relative path, for example `lib/src/d4rt_bridges/x.b.dart`.
  final String path;

  /// How it relates to the package's copy.
  final PreviewedChange change;

  @override
  String toString() => '${change.label}  $path';
}

/// The outcome of [previewGeneration].
class GenerationPreview<T> {
  /// Creates a preview report.
  const GenerationPreview(this.result, this.writes);

  /// What the previewed code returned.
  final T result;

  /// Every file the previewed code wrote, sorted by path.
  final List<PreviewedWrite> writes;
}

/// Drop the `// Generated:` line, the one line that legitimately differs
/// between two generations of identical input — it carries the time, and the
/// generator version.
String normaliseGeneratedContent(String content) => content
    .split('\n')
    .where((line) => !line.trimLeft().startsWith('// Generated:'))
    .join('\n');

/// Run [generate] against the package at [packageRoot] with its `*.b.dart`
/// writes redirected into a scratch tree, and report every file it wrote,
/// compared with the package's own copy.
///
/// The scratch tree lives under the package's gitignored `.dart_tool/`, in a
/// directory unique to this call, and is removed afterwards whether or not
/// [generate] succeeds. [purpose] names the directory, for anyone who finds one
/// left behind by a killed process.
Future<GenerationPreview<T>> previewGeneration<T>({
  required String packageRoot,
  required Future<T> Function() generate,
  String purpose = 'preview',
}) async {
  final root = p.normalize(p.absolute(packageRoot));
  final scratch = Directory(
    p.join(
      root,
      '.dart_tool',
      'tom_d4rt_generator',
      purpose,
      '${pid}_${DateTime.now().microsecondsSinceEpoch}',
    ),
  )..createSync(recursive: true);

  try {
    final result = await runWithScratchOverlay(
      packageRoot: root,
      scratchRoot: scratch.path,
      body: generate,
    );

    final writes = <PreviewedWrite>[];
    for (final entity in scratch.listSync(recursive: true)) {
      if (entity is! File) continue;
      final relative = p.relative(entity.path, from: scratch.path);
      final committed = File(p.join(root, relative));
      final PreviewedChange change;
      if (!committed.existsSync()) {
        change = PreviewedChange.created;
      } else if (normaliseGeneratedContent(entity.readAsStringSync()) ==
          normaliseGeneratedContent(committed.readAsStringSync())) {
        change = PreviewedChange.unchanged;
      } else {
        change = PreviewedChange.changed;
      }
      writes.add(PreviewedWrite(relative, change));
    }
    writes.sort((a, b) => a.path.compareTo(b.path));
    return GenerationPreview(result, writes);
  } finally {
    if (scratch.existsSync()) scratch.deleteSync(recursive: true);
  }
}
