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
// (by scd51) the same day this guard was written. Excluding it, the set is 65.
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
/// names and 88 test files.
///
/// Dominated by `dart:io`, `dart:isolate` and `dart:convert` — the sockets, the
/// process and filesystem enums, the ports, the codecs. Those are the hardest
/// to exercise from a registration-level test and the ones `tom_d4rt` covers
/// behaviourally, which is why they are pinned rather than chased.
///
/// **THIS SET WAS 23 AND BECAME 66 AT SCD67**, without a single bridge losing
/// coverage: the 43 added were only ever "named" in a comment or inside a
/// string literal, and [_codeOnly] stopped counting those. Zero names dropped,
/// which is the check that the stricter rule is a strict tightening rather
/// than a different question — so the old 23 was not a smaller gap, it was the
/// same gap measured through prose.
///
/// **IT IS 65 SINCE SCD70**, which took `FileMode` out the way the list is
/// meant to shrink: a test named it in code. That is the ratchet working in
/// the direction nobody has to remember — F-SCD58-3 failed on the commit that
/// added the coverage, and deleting the line was the fix.
///
/// DELETING A LINE IS HOW COVERAGE IS CLAIMED. `F-SCD58-3` fails on an entry
/// that IS named now, so the list cannot quietly outlive the gap it records —
/// without that it would only ever grow, and a baseline nobody prunes stops
/// being a record and becomes a permission.
const uncoveredBridges = <String>{
  'AsciiCodec',
  'ByteBuffer',
  'Capability',
  'ChunkedConversionSink',
  'Codec',
  'Comparable',
  'ConnectionTask',
  'Encoding',
  'Enum',
  'EventSink',
  'Exception',
  'FileLock',
  'FileStat',
  'FileSystemEntity',
  'FileSystemEntityType',
  'FileSystemEvent',
  'HttpClientBasicCredentials',
  'HttpClientBearerCredentials',
  'HttpClientCredentials',
  'HttpClientDigestCredentials',
  'HttpClientRequest',
  'HttpClientResponse',
  'HttpConnectionInfo',
  'HttpDate',
  'HttpResponse',
  'HttpSession',
  'IOException',
  'Isolate',
  'IsolateSpawnException',
  'JsonCodec',
  'Latin1Codec',
  'Match',
  'MultiStreamController',
  'NetworkInterface',
  'Never',
  'Null',
  'Pattern',
  'Pipe',
  'Point',
  'ProcessStartMode',
  'Random',
  'RandomAccessFile',
  'RawDatagramSocket',
  'RawReceivePort',
  'RawServerSocket',
  'RawSocket',
  'RawSocketEvent',
  'ReceivePort',
  'Rectangle',
  'RegExpMatch',
  'RemoteError',
  'Runes',
  'SendPort',
  'ServerSocket',
  'Sink',
  'Socket',
  'SocketDirection',
  'SocketOption',
  'Stdin',
  'Stdout',
  'StringSink',
  'Symbol',
  'TransferableTypedData',
  'Utf8Codec',
  'WebSocketStatus',
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

/// [source] with its comments and string literals blanked out, so only CODE is
/// searched for bridge names.
///
/// THE THIRD EXCLUSION, and found the same way as the other two — by the scan
/// going wrong. `Null` is a registered bridge AND an ordinary English word, so
/// a test whose header discusses null patterns, or which asserts on the SDK
/// message `'Null check operator used on a null value'`, made `Null` read as
/// covered while nothing exercised the bridge at all. That is the guard's own
/// stated principle one level further in: prose ABOUT a name is not a test
/// naming it, exactly as a list about the gap is not coverage of it.
///
/// It is a lexer, not a parser, and deliberately so. The exact question — "does
/// this identifier appear in an expression position" — needs the analyzer, and
/// this package has no analyzer to spend (zero runtime dependencies is the
/// point of the twin). Blanking comments and string bodies removes the whole
/// class of false positives that actually occurs, and the failure mode of
/// getting it slightly wrong is a name reading as UNCOVERED when it is covered
/// — which fails loudly on [uncoveredBridges] rather than quietly granting
/// permission. The cheap approximation errs in the safe direction.
String _codeOnly(String source) {
  final out = StringBuffer();
  var i = 0;
  while (i < source.length) {
    final rest = source.length - i;
    if (rest >= 2 && source.startsWith('//', i)) {
      final end = source.indexOf('\n', i);
      i = end == -1 ? source.length : end;
      continue;
    }
    if (rest >= 2 && source.startsWith('/*', i)) {
      final end = source.indexOf('*/', i + 2);
      i = end == -1 ? source.length : end + 2;
      continue;
    }
    final quote = source[i];
    if (quote == "'" || quote == '"') {
      final triple = quote * 3;
      final delimiter = source.startsWith(triple, i) ? triple : quote;
      i += delimiter.length;
      while (i < source.length) {
        if (source[i] == r'\') {
          i += 2;
          continue;
        }
        if (source.startsWith(delimiter, i)) {
          i += delimiter.length;
          break;
        }
        i++;
      }
      continue;
    }
    out.write(quote);
    i++;
  }
  return out.toString();
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
  //   * THIS FILE. `uncoveredBridges` below names all 65 pinned bridges, so
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
    sources.add(_codeOnly(text));
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
          '65 bridges it pins, and F-SCD58-3 reports the whole baseline as '
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
  //   | the generated-file exclusion dropped               | 3, x65  |
  //   | the SELF exclusion dropped                         | 3, x65  |
  //   | _codeOnly dropped (comments and strings counted)   | 3, x44  |
  //   | this file renamed without updating the skip        | 1 and 3 |
  //   | the test-source walk pointed at a missing directory| 1       |
  //
  // The two exclusion rows are the ones worth keeping: without either, every
  // pinned name reads as covered and F-SCD58-3 reports all 65 at once — which
  // is what a reader would see if somebody "simplified" a skip away. The
  // `_codeOnly` row is the same shape and is how the stripper was added at
  // all: SCD64's test asserts the SDK message `'Null check operator used on a
  // null value'`, the word `Null` is a registered bridge, and the guard
  // reported it as covered. Its 44 is 43 prose-only names plus that `Null` —
  // the one that was already pinned, and the one that made the other 43
  // visible.
  //
  // The rename row fires 1 AND 3, which was not the prediction: F-SCD58-1's
  // `selfSeen` check names the cause, and F-SCD58-3 then reports the
  // consequence. Read the first — the 65 in the second are not a finding.
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
