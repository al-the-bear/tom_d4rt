// SCD58 — adding a bridge that no test names is not silent any more.
//
// scc16 found one registered-but-untested bridge by hand; scd57 found two more
// by asking the same question of one registrar. The question is mechanical and
// nothing asked it, so the answer only ever came from somebody looking.
//
// THIS IS A RATCHET, NOT A CAMPAIGN. The names already uncovered are pinned in
// [uncoveredBridges] and the suite stays green over them. What fails is a name
// that is NOT in that list — the next bridge registered without a test. Most of
// the pinned types are exercised behaviourally in `tom_d4rt`, where a script
// can actually run, and nothing here authorises writing twenty-three new
// suites. Claiming coverage is deleting a line.
//
// WHAT "COVERED" MEANS HERE, AND WHY IT IS WEAK ON PURPOSE. A bridge counts as
// covered if its name appears as a word anywhere in this tree's tests. That is
// much weaker than "exercised": `UnmodifiableMapView` was named in two files
// and still had seven of its nine mutators never invoked (scc16, then scd56).
// The measurement is a LOWER BOUND on the gap, and it is worth having anyway
// because it costs one test and catches total absence — which is what scc16
// and scd57 both actually were.
//
// GENERATED FILES ARE EXCLUDED, and this is the part that decides whether the
// guard means anything at all. `test/stdlib_member_baseline.dart` is written by
// `tool/stdlib_member_audit.dart` and lists EVERY registered bridge name in its
// `auditedClasses` set. Counting it, the unmentioned set is **zero** — the scan
// would have been perfectly green and perfectly meaningless, and it was added
// (by scd51) the same day this guard was written. Excluding it, the set is 23.
// A file that is a generated list of names is data, not somebody's test naming
// a bridge, so any test file whose first lines say `GENERATED` is skipped.
//
// EACH CASE HAS BEEN SEEN TO FAIL; the matrix is above F-SCD58-2.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';

/// Bridges no test in this tree names, measured 2026-09-12 over 205 registered
/// names and 86 test files.
///
/// Dominated by `dart:io` and `dart:isolate` — the sockets, the process and
/// filesystem enums, the ports. Those are the hardest to exercise from a
/// registration-level test and the ones `tom_d4rt` covers behaviourally, which
/// is why they are pinned rather than chased.
///
/// DELETING A LINE IS HOW COVERAGE IS CLAIMED. `F-SCD58-3` fails on an entry
/// that IS named now, so the list cannot quietly outlive the gap it records —
/// without that it would only ever grow, and a baseline nobody prunes stops
/// being a record and becomes a permission.
const uncoveredBridges = <String>{
  'Capability',
  'ConnectionTask',
  'FileLock',
  'FileMode',
  'FileSystemEntityType',
  'FileSystemEvent',
  'Isolate',
  'MultiStreamController',
  'NetworkInterface',
  'Null',
  'Pipe',
  'Point',
  'RawDatagramSocket',
  'RawReceivePort',
  'RawServerSocket',
  'RawSocketEvent',
  'ReceivePort',
  'RemoteError',
  'ServerSocket',
  'Socket',
  'SocketDirection',
  'SocketOption',
  'TransferableTypedData',
};

/// Floors under two emptiness assertions. A walk that registered nothing, or
/// read no test files, satisfies both — the trap `F-SCB24-2` exists for, where
/// a scan read 0 of 205 names and its guard passed.
const _minRegistered = 150;
const _minTestFiles = 50;

Environment _fullyRegisteredEnvironment() {
  final env = Environment();
  Stdlib(env).register();
  MathStdlib.register(env);
  ConvertStdlib.register(env);
  IoStdlib.register(env);
  CollectionStdlib.register(env);
  IsolateStdlib.register(env);
  return env;
}

void main() {
  final registered = _fullyRegisteredEnvironment().bridgedClassNames..sort();

  final testFiles = Directory('test')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  // Hand-written test sources only, and not this file.
  //
  // TWO EXCLUSIONS, BOTH LOAD-BEARING, and each was found by the scan going
  // wrong rather than by foresight:
  //
  //   * a GENERATED file. `stdlib_member_baseline.dart` lists every registered
  //     name in `auditedClasses`, so counting it puts the unmentioned set at
  //     ZERO — green and meaningless. See the file header.
  //   * THIS FILE. `uncoveredBridges` below names all 23 pinned bridges, so
  //     counting it makes every one of them read as covered and F-SCD58-3
  //     reports the entire baseline as stale on the first run. It did.
  //
  // The second is the same trap as the first, one level in: a list ABOUT the
  // gap is not coverage OF it.
  var selfSeen = false;
  final sources = <String>[];
  for (final file in testFiles) {
    if (file.path.endsWith('scd58_bridge_coverage_baseline_test.dart')) {
      selfSeen = true;
      continue;
    }
    final text = file.readAsStringSync();
    final head = text.split('\n').take(3).join('\n');
    if (head.contains('GENERATED')) continue;
    sources.add(text);
  }

  bool isNamed(String bridge) {
    final word = RegExp('\\b${RegExp.escape(bridge)}\\b');
    return sources.any(word.hasMatch);
  }

  final unnamed = registered.where((n) => !isNamed(n)).toSet();

  test('F-SCD58-1: the scan read a real registry and a real test tree '
      '[2026-09-12]', () {
    expect(
      registered.length,
      greaterThanOrEqualTo(_minRegistered),
      reason:
          'Only ${registered.length} bridges registered. That is not a '
          'coverage finding — the registrars did not run, and every name '
          'would then read as covered by absence.',
    );
    // The self-exclusion is by NAME, so a rename would silently stop applying
    // it and every pinned bridge would read as covered again. Asserting the
    // skip matched something is what makes the rename loud instead.
    expect(
      selfSeen,
      isTrue,
      reason:
          'This file excluded itself by filename and did not find itself in '
          'the walk, so it was renamed. Update the name in the skip — '
          'otherwise its own uncoveredBridges list counts as coverage of the '
          '23 bridges it pins, and F-SCD58-3 reports the whole baseline as '
          'stale.',
    );
    expect(
      sources.length,
      greaterThanOrEqualTo(_minTestFiles),
      reason:
          'Read only ${sources.length} hand-written test sources. With too '
          'few, every bridge reads as UNCOVERED and F-SCD58-2 reports the '
          'whole registry. Tests are expected to run with the package root as '
          'the working directory.',
    );
  });

  // EACH ROW OBSERVED, by breaking the thing named:
  //
  //   | Injected fault                                    | Fires |
  //   | ------------------------------------------------- | ----- |
  //   | a baselined name removed from the list             | 2     |
  //   | a baselined name given a mention in a test         | 3     |
  //   | the generated-file exclusion dropped               | 3, x23  |
  //   | the SELF exclusion dropped                         | 3, x23  |
  //   | this file renamed without updating the skip        | 1 and 3 |
  //   | the test-source walk pointed at a missing directory| 1       |
  //
  // The two exclusion rows are the ones worth keeping: without either, every
  // pinned name reads as covered and F-SCD58-3 reports all 23 at once — which
  // is what a reader would see if somebody "simplified" a skip away.
  //
  // The rename row fires 1 AND 3, which was not the prediction: F-SCD58-1's
  // `selfSeen` check names the cause, and F-SCD58-3 then reports the
  // consequence. Read the first — the 23 in the second are not a finding.
  test('F-SCD58-2: every registered bridge is named by some test '
      '[2026-09-12]', () {
    final newlyUncovered = unnamed.difference(uncoveredBridges).toList()
      ..sort();
    expect(
      newlyUncovered,
      isEmpty,
      reason:
          'These bridges are registered and no test in this tree names '
          'them:\n  ${newlyUncovered.join('\n  ')}\n\n'
          'A bridge nobody names is one scc16 and scd57 both had to find by '
          'hand. Add a test — `scd57_linked_list_bridge_test.dart` is the '
          'registration-level shape — or, if it belongs with the pinned set, '
          'add it to uncoveredBridges and say in the commit why it is not '
          'worth a suite.',
    );
  });

  test('F-SCD58-3: every pinned name is still uncovered [2026-09-12]', () {
    final nowCovered = uncoveredBridges.difference(unnamed).toList()..sort();
    expect(
      nowCovered,
      isEmpty,
      reason:
          'These names are pinned as uncovered and a test names them now:\n'
          '  ${nowCovered.join('\n  ')}\n\n'
          'Good news — delete them from uncoveredBridges in the same commit '
          'as the test that covers them. Left in, the list stops recording a '
          'gap and starts granting permission, and F-SCD58-2 would no longer '
          'fire if the coverage were later deleted.',
    );
  });
}
