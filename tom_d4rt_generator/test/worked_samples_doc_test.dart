/// Byte-safe drift guard for the worked-samples catalog.
///
/// `doc/worked_samples.md` maps the runnable multi-file sample apps under
/// `tom_d4rt_flutter_test/example/` to the generation mechanisms they exercise.
/// The full executable-docs check (running each sample through the
/// `SourceFlutterD4rt` runner) is a `flutter test` under the serial gate; this
/// pure-Dart guard is its byte-safe complement — it asserts that every sample
/// the doc names still exists on disk, so a renamed or deleted example fails
/// here (fast, no flutter) long before the heavyweight harness runs.
///
/// Mirrors the sibling-path approach of `corpus_allowlist_reconciliation_test`.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Resolves a path relative to the `tom_d4rt_generator` package root, whatever
/// the test runner's CWD happens to be.
String _fromPackageRoot(String relative) {
  // This file lives at <pkg>/test/worked_samples_doc_test.dart.
  final testFileDir = p.dirname(Platform.script.toFilePath());
  for (final base in <String>[
    p.normalize(p.join(testFileDir, '..')),
    Directory.current.path,
  ]) {
    final candidate = p.normalize(p.join(base, relative));
    if (File(candidate).existsSync() || Directory(candidate).existsSync()) {
      return candidate;
    }
  }
  return p.normalize(p.join(Directory.current.path, relative));
}

const _docRelative = 'doc/worked_samples.md';
const _exampleRootRelative = '../tom_d4rt_flutter_test/example';

/// Extracts the sample names from the catalog table rows of
/// `worked_samples.md`. Catalog rows look like:
///
/// ```text
/// | `counter_app` | ... | ... |
/// ```
///
/// so we take the backtick-wrapped token in the **first** cell of every table
/// row whose first cell is a single `snake_case` identifier.
Set<String> _catalogSamples(String markdown) {
  final samples = <String>{};
  final rowFirstCell = RegExp(r'^\|\s*`([a-z][a-z0-9_]*)`\s*\|');
  for (final line in const LineSplitter().convert(markdown)) {
    final match = rowFirstCell.firstMatch(line.trim());
    if (match != null) samples.add(match.group(1)!);
  }
  return samples;
}

void main() {
  group('worked_samples.md drift guard', () {
    late String markdown;
    late Set<String> samples;
    late String exampleRoot;

    setUpAll(() {
      final docPath = _fromPackageRoot(_docRelative);
      markdown = File(docPath).readAsStringSync();
      samples = _catalogSamples(markdown);
      exampleRoot = _fromPackageRoot(_exampleRootRelative);
    });

    test('G-WSD-1: the catalog names at least the five worked samples', () {
      expect(
        samples,
        containsAll(<String>{
          'calculator',
          'clock_face',
          'counter_app',
          'stopwatch_laps',
          'tip_calculator',
        }),
        reason: 'worked_samples.md must catalog the five named worked samples',
      );
    });

    test('G-WSD-2: the example root resolves to a real directory', () {
      expect(
        Directory(exampleRoot).existsSync(),
        isTrue,
        reason: 'expected example root at $exampleRoot',
      );
    });

    test('G-WSD-3: every catalogued sample has an example/<app>/main.dart', () {
      final missing = <String>[];
      for (final sample in samples) {
        final main = p.join(exampleRoot, sample, 'main.dart');
        if (!File(main).existsSync()) missing.add('$sample → $main');
      }
      expect(
        missing,
        isEmpty,
        reason: 'documented samples with no main.dart on disk (rotted refs):\n'
            '${missing.join('\n')}',
      );
    });

    test('G-WSD-4: the catalog is non-trivial (parser sanity)', () {
      // Guards against the row regex silently matching nothing after an edit.
      expect(samples.length, greaterThanOrEqualTo(5));
    });
  });
}
