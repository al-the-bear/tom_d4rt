/// Clear `F-SCC45-2` — upgrade every lock in this repo that resolves a `tom_*`
/// package older than one the pub cache already holds.
///
/// ## Why this exists
///
/// SCD206. The guard found the problem and stopped at describing the remedy:
/// "run `dart pub upgrade` (or `flutter pub upgrade`) in the …". Clearing it
/// once meant forty-one findings across twenty-nine packages, each classified
/// by hand as a Dart or a Flutter package by reading its path.
///
/// `pubspec.lock` is gitignored repo-wide (DGUC10), so that work is
/// per-machine and recurs on every fleet host after every publish — and this
/// quest publishes often. A check whose remedy costs that much is one people
/// switch off rather than act on, which is how the guard stops being a guard.
///
/// ## Usage, from anywhere inside the d4rt repo
///
///     dart run tom_d4rt_ast/tool/upgrade_stale_locks.dart --dry-run
///     dart run tom_d4rt_ast/tool/upgrade_stale_locks.dart
///
/// `--dry-run` prints the plan and changes nothing. Without it, each package
/// is upgraded with `flutter pub upgrade` when its pubspec declares the
/// Flutter SDK and `dart pub upgrade` otherwise — the one distinction that
/// matters, read from the pubspec rather than inferred from the path.
///
/// A SECOND PASS then re-resolves the fixtures that reach an upgraded package
/// by `path:`. They carry no stale `tom_*` entry of their own, so the first
/// pass never sees them, but a fixture inherits its host's SOURCE while
/// resolving its OWN dependencies — move the host and it goes on compiling
/// the new `lib/` against the old third-party versions. `G-PARITY-EX` in the
/// three generator packages reports precisely that, and the first sweep this
/// tool ever ran created one. Clearing one guard's red by creating another's
/// is not a remedy. The pass runs `pub upgrade`, not `pub get`: `get` is
/// lock-preserving and would leave the fixture exactly where it was, which is
/// the SCC45 mechanism this file exists for arriving one directory down.
///
/// The dry run does not plan the second pass — which fixtures need it is a
/// function of which packages actually moved.
///
/// ## It shares its definition with the guard
///
/// `tool/stale_locks.dart` holds the walk, the lock parse and the comparison,
/// and `scc45_resolution_guard_test.dart` imports the same file. A tool that
/// clears a red the guard still reports is worse than either alone.
///
/// ## What a green run does NOT mean
///
/// Upgrading a Flutter twin's lock moves the bridge corpus onto a new
/// interpreter WITHOUT re-running it. That is the whole DGUC6 hazard, arriving
/// by a side door: the corpus result on record was measured against the
/// version this command just replaced. The exit banner says so when a twin or
/// a companion app was touched, because the alternative is a green guard
/// reading as though the corpus had been re-measured.
library;

import 'dart:io';

import 'stale_locks.dart';

/// Packages whose lock moving invalidates a recorded corpus run.
const _corpusPackages = <String>{
  'tom_d4rt_flutter',
  'tom_d4rt_flutter_ast',
  'tom_d4rt_flutter/test/tom_d4rt_flutter_test_app',
  'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app',
};

Future<int> main(List<String> args) async {
  final dryRun = args.contains('--dry-run');
  if (args.any((a) => a.startsWith('-') && a != '--dry-run')) {
    stderr.writeln('usage: upgrade_stale_locks.dart [--dry-run]');
    return 2;
  }

  final root = repoRoot();
  if (root == null) {
    stderr.writeln(
      'Could not find the d4rt repo root above ${Directory.current.path}. '
      'This looks for a directory holding ${repoMarkers.join(', ')} — run it '
      'from inside the repo.',
    );
    return 2;
  }

  final stale = staleLocks(root);
  if (stale.isEmpty) {
    stdout.writeln(
      'No lock in ${root.path} is behind a version already in the pub cache.\n'
      '\n'
      'NOTE this is a statement about THIS machine: the cache is the '
      'discriminator, so a cold cache reports nothing and looks identical to a '
      'clean repo. `F-SCC45-2` skips rather than passes when the cache is too '
      'thin to tell them apart.',
    );
    return 0;
  }

  // Group by package: one upgrade fixes every stale entry in a lock, and
  // running pub once per FINDING would run it three times for a package with
  // three stale dependencies.
  final byPackage = <String, List<StaleLock>>{};
  for (final s in stale) {
    (byPackage[s.package] ??= <StaleLock>[]).add(s);
  }

  stdout.writeln(
    '${stale.length} stale ${stale.length == 1 ? 'entry' : 'entries'} across '
    '${byPackage.length} ${byPackage.length == 1 ? 'package' : 'packages'}'
    '${dryRun ? ' (dry run — nothing will be changed)' : ''}:\n',
  );

  var failed = 0;
  var upgraded = 0;
  final corpusTouched = <String>[];
  final movedNames = <String>{};

  for (final rel in byPackage.keys.toList()..sort()) {
    final package = Directory('${root.path}/$rel');
    final flutter = isFlutterPackage(package);
    final command = flutter ? 'flutter' : 'dart';
    final what = byPackage[rel]!
        .map((s) => '${s.dependency} ${s.locked}→${s.cached}')
        .join(', ');

    stdout.writeln('  $rel');
    stdout.writeln('      $what');
    stdout.writeln('      \$ $command pub upgrade');

    if (_corpusPackages.contains(rel)) corpusTouched.add(rel);
    if (dryRun) continue;

    final result = await Process.run(command, [
      'pub',
      'upgrade',
    ], workingDirectory: package.path);
    if (result.exitCode == 0) {
      upgraded++;
      final name = packageName(package);
      if (name != null) movedNames.add(name);
    } else {
      failed++;
      stdout.writeln('      FAILED (exit ${result.exitCode})');
      final err = (result.stderr as String).trim();
      if (err.isNotEmpty) {
        stdout.writeln('      ${err.split('\n').take(4).join('\n      ')}');
      }
    }
  }

  if (dryRun) {
    stdout.writeln(
      '\nDry run. Re-run without --dry-run to apply, then re-run '
      '`dart test test/scc45_resolution_guard_test.dart` in tom_d4rt_ast.\n'
      'The real run adds a second pass over the path-linked fixtures of '
      'whatever moved; it is not planned here, because which fixtures need it '
      'depends on which upgrades actually took.',
    );
    return 0;
  }

  stdout.writeln('\n$upgraded upgraded, $failed failed.');

  // SECOND PASS: re-resolve the fixtures that reach an upgraded package by
  // `path:`. They hold no stale `tom_*` entry of their own, so the first pass
  // does not see them — but a fixture inherits its host's SOURCE while
  // resolving its OWN dependencies, so moving the host leaves it compiling the
  // new `lib/` against the old third-party versions. `G-PARITY-EX` reports
  // that, and clearing one guard's red by creating another's is not a remedy.
  //
  // UPGRADE, NOT GET. `pub get` is lock-preserving and leaves the fixture
  // exactly where it was — which is the SCC45 mechanism this whole file exists
  // for, arriving one directory further down.
  final dependents = pathLinkedDependents(root, movedNames);
  if (dependents.isNotEmpty) {
    stdout.writeln(
      '\n${dependents.length} path-linked '
      '${dependents.length == 1 ? 'fixture reaches' : 'fixtures reach'} an '
      'upgraded package and must re-resolve with it:',
    );
    for (final fixture in dependents) {
      final rel = relativeTo(root, fixture);
      final command = isFlutterPackage(fixture) ? 'flutter' : 'dart';
      stdout.writeln('  $rel  \$ $command pub upgrade');
      final result = await Process.run(command, [
        'pub',
        'upgrade',
      ], workingDirectory: fixture.path);
      if (result.exitCode != 0) {
        failed++;
        stdout.writeln('      FAILED (exit ${result.exitCode})');
      }
    }
  }

  // Re-measure rather than assert: an upgrade can leave a lock behind when a
  // constraint pins it, and reporting success on the basis of exit codes alone
  // would hide exactly that.
  final remaining = staleLocks(root);
  if (remaining.isEmpty) {
    stdout.writeln('Every stale lock cleared — F-SCC45-2 should now pass.');
  } else {
    stdout.writeln(
      '${remaining.length} still stale after upgrading. `pub upgrade` respects '
      'the pubspec, so a lock that will not move is a CONSTRAINT holding it '
      'there — raise the constraint rather than re-running this:\n'
      '${remaining.map((s) => '  $s').join('\n')}',
    );
  }

  if (corpusTouched.isNotEmpty) {
    stdout.writeln(
      '\nTHE BRIDGE CORPUS NOW MEASURES A DIFFERENT INTERPRETER. These moved:\n'
      '${corpusTouched.map((p) => '  $p').join('\n')}\n'
      'Any corpus result on record was measured against the version just '
      'replaced (DGUC6). A green F-SCC45-2 is not a re-measurement — re-run '
      './test/run_base_tests.sh in each twin, SERIALLY, and record the run.',
    );
  }

  return failed == 0 && remaining.isEmpty ? 0 : 1;
}
