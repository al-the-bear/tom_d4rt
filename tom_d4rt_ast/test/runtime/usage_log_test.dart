/// Tests for the P&R#1 relaxer/proxy/ctor usage log on [D4]
/// (`D4.usageLogEnabled`, `recordUsageHit`, `recordUsageMiss`,
/// `usageLogSummary`, `resetUsageLog`).
///
/// The usage log drives the mass-generation reduction work (P&R steps 4–5):
/// it records which generated relaxer / proxy / coercion / generic-constructor
/// cases real scripts actually exercise, plus the unresolved misses. The
/// contract verified here is the same on the analyzer-based `tom_d4rt` twin —
/// see `tom_d4rt/test/bridge/usage_log_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  // The log lives on process-global static fields, so each test must start
  // from a clean, disabled slate.
  setUp(() {
    D4.usageLogEnabled = false;
    D4.resetUsageLog();
  });
  tearDown(() {
    D4.usageLogEnabled = false;
    D4.resetUsageLog();
  });

  group('disabled by default', () {
    test('records are silent and zero-overhead when off', () {
      expect(D4.usageLogEnabled, isFalse);
      // Calls are no-ops while disabled — no key allocation, no counting.
      D4.recordUsageHit('relaxer', 'List', 'Color');
      D4.recordUsageMiss('CustomPainter', '');
      expect(D4.usageHits, isEmpty);
      expect(D4.usageMisses, isEmpty);
      expect(D4.usageHitCount, 0);
      expect(D4.usageMissCount, 0);
    });

    test('summary reports nothing recorded', () {
      final summary = D4.usageLogSummary();
      expect(summary, contains('=== D4 relaxer/proxy/ctor usage log ==='));
      expect(summary, contains('(no relaxer/proxy/ctor lookups recorded)'));
    });
  });

  group('enabled', () {
    setUp(() => D4.usageLogEnabled = true);

    test('a hit records category, base and type-arg in the key', () {
      D4.recordUsageHit('relaxer', 'List', 'Color');
      expect(D4.usageHits, {'relaxer|List|Color': 1});
      expect(D4.usageHitCount, 1);
      expect(D4.usageMisses, isEmpty);
    });

    test('repeated identical hits aggregate by count', () {
      D4.recordUsageHit('proxy', 'CustomPainter', 'MyPainter');
      D4.recordUsageHit('proxy', 'CustomPainter', 'MyPainter');
      D4.recordUsageHit('proxy', 'CustomPainter', 'MyPainter');
      expect(D4.usageHits['proxy|CustomPainter|MyPainter'], 3);
      expect(D4.usageHitCount, 3);
    });

    test('distinct categories and bases are keyed separately', () {
      D4.recordUsageHit('relaxer', 'List', 'int');
      D4.recordUsageHit('coercion', 'TextStyle', 'TextStyle');
      D4.recordUsageHit('ctor', 'ValueNotifier', 'int');
      expect(D4.usageHits.keys, containsAll(<String>[
        'relaxer|List|int',
        'coercion|TextStyle|TextStyle',
        'ctor|ValueNotifier|int',
      ]));
      expect(D4.usageHitCount, 3);
      expect(D4.usageHits.length, 3);
    });

    test('a miss is recorded under the miss category', () {
      D4.recordUsageMiss('CustomClipper', 'Path');
      expect(D4.usageMisses, {'miss|CustomClipper|Path': 1});
      expect(D4.usageMissCount, 1);
      expect(D4.usageHits, isEmpty);
    });

    test('summary lists hits and misses sorted by descending count', () {
      D4.recordUsageHit('relaxer', 'List', 'Color');
      D4.recordUsageHit('relaxer', 'List', 'Color');
      D4.recordUsageHit('proxy', 'CustomPainter', 'P');
      D4.recordUsageMiss('CustomClipper', 'Path');

      final summary = D4.usageLogSummary();
      expect(summary, contains('Hits: 3 event(s), 2 distinct'));
      expect(summary, contains('2× relaxer|List|Color'));
      expect(summary, contains('1× proxy|CustomPainter|P'));
      expect(summary, contains('Misses: 1 event(s), 1 distinct'));
      expect(summary, contains('1× miss|CustomClipper|Path'));
      // The 2× hit must sort ahead of the 1× hit within the Hits section.
      expect(
        summary.indexOf('relaxer|List|Color'),
        lessThan(summary.indexOf('proxy|CustomPainter|P')),
      );
    });

    test('resetUsageLog clears all accumulated data', () {
      D4.recordUsageHit('relaxer', 'List', 'Color');
      D4.recordUsageMiss('CustomClipper', 'Path');
      expect(D4.usageHitCount, 1);
      expect(D4.usageMissCount, 1);

      D4.resetUsageLog();
      expect(D4.usageHits, isEmpty);
      expect(D4.usageMisses, isEmpty);
      expect(D4.usageHitCount, 0);
      expect(D4.usageMissCount, 0);
    });

    test('exposed maps are unmodifiable snapshots', () {
      D4.recordUsageHit('relaxer', 'List', 'Color');
      expect(() => D4.usageHits['x'] = 1, throwsUnsupportedError);
      expect(() => D4.usageMisses['x'] = 1, throwsUnsupportedError);
    });
  });
}
