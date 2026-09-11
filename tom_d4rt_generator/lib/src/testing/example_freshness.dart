/// Building blocks for a package's test of its `example/` projects' bridges.
///
/// Example projects carry `buildkit_skip.yaml`, so no workspace-wide scan
/// reaches them and nothing notices when their committed bridges fall behind
/// the generator. The package that owns them is the one place a test can
/// notice, and these functions are that test minus its `package:test` calls:
///
/// ```dart
/// const knownStale = <String>{'user_guide'};
///
/// void main() {
///   for (final example in findD4rtgenProjects('example')) {
///     test('example/$example bridges', () async {
///       final root = p.absolute('example', example);
///       expect(await resolveIfUnresolved(root), isNull);
///       final verdict = freshnessRatchetViolation(
///         example,
///         await checkBridgeFreshness(root),
///         knownStale: knownStale.contains(example),
///       );
///       expect(verdict, isNull, reason: verdict);
///     }, timeout: const Timeout(Duration(minutes: 5)));
///   }
/// }
/// ```
///
/// THE RATCHET. A project listed as known-stale must still be stale: once it
/// is regenerated, its verdict demands the entry be deleted. A project not
/// listed must be fresh. So the list can only shrink, and no new staleness
/// can land while the backlog is paid down.
library;

import '../bridge_freshness.dart';
import 'project_discovery.dart';

/// Directories under [root] whose `buildkit.yaml` has a `d4rtgen:` section,
/// relative to [root] and sorted. `.dart_tool` and `build` trees are skipped.
List<String> findD4rtgenProjects(String root) => projectDirectoriesUnder(
  root,
  'buildkit.yaml',
  accept: (file) => _d4rtgenSection.hasMatch(file.readAsStringSync()),
);

final _d4rtgenSection = RegExp(r'^d4rtgen:', multiLine: true);

/// What is wrong with [project]'s [freshness] under the ratchet, or null.
///
/// [knownStale] says whether the project is on the caller's known-stale list.
/// A report with errors is always a violation: it has measured nothing, and
/// "known stale" must not excuse a generator that failed to run.
String? freshnessRatchetViolation(
  String project,
  BridgeFreshness freshness, {
  required bool knownStale,
}) {
  if (freshness.errors.isNotEmpty) {
    return '$project: generation failed, so nothing was compared:\n  '
        '${freshness.errors.join('\n  ')}';
  }
  if (freshness.checked.isEmpty) {
    return '$project: the generator produced nothing, so nothing was compared.';
  }
  if (knownStale) {
    return freshness.isFresh
        ? '$project is fresh now — delete it from the known-stale list so it '
              'stays fresh.'
        : null;
  }
  return freshness.isFresh
      ? null
      : '$project: regenerate it and commit everything that changes:\n  '
            '${freshness.stale.join('\n  ')}';
}
