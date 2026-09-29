// RUNNER BUCKET: guard — run_guard_tests.sh
//
// SCE199 — `tool/verification_row.dart` turns a run folder's attribution
// header into `Verification runs` table rows, and says so when it cannot.
//
// Fixture headers, not real run folders: `testlog/` is gitignored and
// per-machine, so a case reading one would pass or fail on whether this host
// still holds the run.
library;

import 'package:flutter_test/flutter_test.dart';

import '../tool/verification_row.dart';

const _astHosted = [
  '# run: fixture-ast',
  '# started: 2026-09-28T10:00:00',
  '# package: tom_d4rt_flutter_ast 0.6.0',
  '# app: test/tom_d4rt_flutter_ast_app',
  '# resolved: tom_ast_model 0.2.0 (hosted)',
  '# resolved: tom_d4rt 1.77.0 (hosted)',
  '# resolved: tom_d4rt_ast 0.65.0 (hosted)',
  '# resolved: tom_d4rt_generator 1.28.0 (hosted)',
  '# app-resolved: tom_d4rt_ast 0.65.0 (hosted)',
  '# app-resolved: tom_d4rt_flutter_ast 0.6.0 (path)',
  '# tree: tom_d4rt_ast 0.65.0 vs 0.171.0 — behind',
  'flutter_base_01_test.dart: exit=0 +50',
];

const _sourceHosted = [
  '# run: fixture-src',
  '# package: tom_d4rt_flutter 0.6.0',
  '# app: test/tom_d4rt_flutter_test_app',
  '# resolved: tom_d4rt 1.77.0 (hosted)',
  '# resolved: tom_d4rt_generator 1.28.0 (hosted)',
  '# app-resolved: tom_d4rt 1.77.0 (hosted)',
  'flutter_base_01_test.dart: exit=0 +50',
];

void main() {
  test('F-SCE199-1: a hosted pair of runs yields the document\'s rows, in its '
      'order [2026-09-28]', () {
    final result = verificationRows([
      ('ast', _astHosted),
      ('src', _sourceHosted),
    ]);
    expect(result.problems, isEmpty);
    expect(result.warnings, isEmpty);
    expect(result.rows, [
      '| `tom_d4rt_flutter` | **1.77.0** | — | **1.28.0** |',
      '| `tom_d4rt_flutter/test/tom_d4rt_flutter_test_app` | **1.77.0** | — | — |',
      '| `tom_d4rt_flutter_ast` | **1.77.0** | **0.65.0** | **1.28.0** |',
      '| `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app` | — | **0.65.0** | — |',
    ]);
  });

  test('F-SCE199-2: a folder with no usable header yields no rows and says '
      'why [2026-09-28]', () {
    final result = verificationRows([
      ('missing', null),
      ('pre-scd164', ['flutter_base_01_test.dart: exit=0 +50']),
      (
        'failed',
        [
          '# run: x',
          '# attribution: FAILED — expected <parentDir> <appDir> <runId>',
        ],
      ),
    ]);
    expect(result.rows, isEmpty);
    expect(result.problems, hasLength(3));
    expect(result.problems[0], contains('no metrics.txt'));
    expect(result.problems[1], contains('SCD164'));
    expect(result.problems[2], contains('attribution FAILED'));
    expect(result.problems[2], contains('expected <parentDir>'));
  });

  test('F-SCE199-3: a PATH resolution is shown and flagged, never passed off '
      'as a recordable version [2026-09-28]', () {
    final pathRun = [
      for (final l in _astHosted)
        l.replaceAll(
          'tom_d4rt_ast 0.65.0 (hosted)',
          'tom_d4rt_ast 0.171.0 (path)',
        ),
    ];
    final result = verificationRows([('prepublish', pathRun)]);
    expect(result.rows.first, contains('**0.171.0 (path)**'));
    expect(result.warnings, hasLength(2));
    expect(result.warnings.first, contains('must not record'));
  });

  test('F-SCE247-1: each run gets a framework-error line from its trailer, and '
      'a run without one is named rather than printed as zero [2026-09-29]', () {
    final withTrailer = [
      ..._astHosted,
      '## framework-errors: total=3 scripts=2 measured=910',
      '## rejections: total=2 signatures=1',
      "## rejection: 2  type 'dynamic Function()' is not a subtype of type "
          "'VoidCallback' of 'onTap'",
    ];
    expect(
      frameworkErrorLines([('ast', withTrailer), ('src', _sourceHosted)]),
      [
        "- `tom_d4rt_flutter_ast`: 3 framework error(s) in 2 of 910 script(s); "
            "2 refused callback(s) — 2 × `type 'dynamic Function()' is not a "
            "subtype of type 'VoidCallback' of 'onTap'`",
        '- `tom_d4rt_flutter`: NO TRAILER — the runner predates SCE247; count '
            'with `dart run tool/framework_error_inventory.dart src --summary`',
      ],
    );
  });
}
