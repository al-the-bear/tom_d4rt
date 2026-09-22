// The one place the `dclie` binary these tests drive is built.
//
// SCE132. There were two copies of this, and they had DRIFTED: the
// `dcli_example` copy rebuilt when anything under `bin/` or `lib/` changed —
// widened after Cluster STRING-AS-PROCESS, where regenerated `*.b.dart`
// bridges left a stale binary behind — while the `stdin` copy still rebuilt
// only when `bin/dclie.dart` itself changed. So the stdin suite could pass
// against a binary built before the change it was meant to be testing, which
// is a false GREEN and worse than the red it would otherwise show.
//
// Making the narrow copy match the wide one then exposed what the drift had
// been hiding. `dart test` runs files CONCURRENTLY: with both copies willing
// to rebuild, one suite recompiled `bin/dclie` in place while another was
// executing it, and the shell fixture hung until the ten-minute test timeout.
// The narrow trigger had been concealing that by almost never firing.
//
// Hence one copy, and an ATOMIC install: compile to a unique temporary path
// and `rename` it into place. Rename is atomic on POSIX and leaves a running
// process attached to the old inode, so a concurrent rebuild can neither
// corrupt a binary another test is running nor race a second rebuilder —
// whichever finishes last wins, and both outputs are complete.
import 'dart:io';

import 'package:path/path.dart' as p;

/// Every input that can change what the binary does.
///
/// `pubspec.lock` is in the list because an upgraded dependency changes the
/// binary without touching a single file in this package — the shape that
/// makes a stale artifact hardest to notice.
Iterable<File> _inputs(String projectRoot) sync* {
  yield File(p.join(projectRoot, 'pubspec.lock'));
  for (final dir in ['bin', 'lib']) {
    final root = Directory(p.join(projectRoot, dir));
    if (!root.existsSync()) continue;
    for (final entity in root.listSync(recursive: true, followLinks: false)) {
      if (entity is File && entity.path.endsWith('.dart')) yield entity;
    }
  }
}

/// The path to a `dclie` binary that is at least as new as every input,
/// compiling one if the existing binary is missing or stale.
Future<String> ensureDclieBinary(String projectRoot) async {
  final binaryPath = p.join(projectRoot, 'bin', 'dclie');
  final sourcePath = p.join(projectRoot, 'bin', 'dclie.dart');
  final binary = File(binaryPath);

  if (binary.existsSync()) {
    final builtAt = binary.lastModifiedSync();
    final stale = _inputs(
      projectRoot,
    ).any((f) => f.existsSync() && f.lastModifiedSync().isAfter(builtAt));
    if (!stale) return binaryPath;
  }

  // Staged under `.dart_tool/`, which is already ignored — `bin/` is not a
  // safe place for it, because `.gitignore` names `bin/dclie` exactly and
  // `bin/dclie.dart` is tracked, so no widened pattern there is safe.
  final stagingDir = Directory(p.join(projectRoot, '.dart_tool'))
    ..createSync(recursive: true);
  final staging = p.join(
    stagingDir.path,
    'dclie.${pid}_${DateTime.now().microsecondsSinceEpoch}',
  );
  final result = await Process.run('dart', [
    'compile',
    'exe',
    sourcePath,
    '-o',
    staging,
  ], workingDirectory: projectRoot);
  if (result.exitCode != 0) {
    File(staging).existsSync() ? File(staging).deleteSync() : null;
    throw StateError('Failed to compile dclie binary:\n${result.stderr}');
  }
  File(staging).renameSync(binaryPath);
  return binaryPath;
}
