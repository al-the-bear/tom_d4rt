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
// (by scd51) the same day this guard was written. Excluding it, the set is 63.
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

/// Bridges no test in this tree names, re-measured 2026-09-22 over 208
/// registered names and 138 test files (it was 205 and 88 on 2026-09-12, when
/// the set was first written).
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
/// **IT IS 38 SINCE SCE115**, having been 53 after SCD181, 55 after SCD78, 63
/// after SCD71 and 65 after SCD70.
/// Every name that came off before SCE115 did so the way the list is meant to
/// shrink: a test named it in code, F-SCD58-3 failed on the commit that added
/// the coverage, and deleting the line was the fix. That is the ratchet working
/// in the direction nobody has to remember, and it had never moved that way
/// before SCD70.
///
/// **SCE115'S FIFTEEN CAME OFF WITHOUT A TEST BEING WRITTEN**, which is a
/// different move and the reason the sequence is kept rather than overwritten
/// with a number. They were covered all along — `RandomAccessFile`, `Stdin`,
/// `Stdout`, `Utf8Codec` and eleven more are driven by registration-level
/// tests that address them as `bridge('RandomAccessFile')`. The scan blanked
/// the string and could not see its own tree's idiom, so the list overstated
/// the gap. See [_bridgeNamesResolvedInStrings]; the fifteen are, in the
/// order F-SCD58-3 reported them: `ByteBuffer`, `Encoding`, `Exception`,
/// `HttpClientCredentials`, `HttpClientResponse`, `HttpDate`, `IOException`,
/// `JsonCodec`, `RandomAccessFile`, `Rectangle`, `Runes`, `Stdin`, `Stdout`,
/// `StringSink`, `Utf8Codec`.
///
/// So the measurement has now been corrected in BOTH directions — 23 to 66
/// when prose stopped counting, 53 to 38 when the idiom started. Neither move
/// changed what any test does.
///
/// SCD78's eight — `Socket`, `ServerSocket`, `RawSocket`, `RawServerSocket`,
/// `RawDatagramSocket`, `MultiStreamController`, `NetworkInterface` and `Pipe` —
/// came off in one commit because the SCC24 getter sweep acquired instances for
/// them: a loopback exchange, a `Stream.multi` callback, the host's interface
/// list, a pipe pair. Note what kind of coverage that is: the sweep invokes
/// every registered getter and checks the value resolves. It is not behavioural
/// coverage of what a socket DOES, and this list does not claim to measure
/// that. `NetworkInterface` is the one conditional entry — a host reporting no
/// interfaces leaves it unswept, though the name is still in code.
///
/// DELETING A LINE IS HOW COVERAGE IS CLAIMED. `F-SCD58-3` fails on an entry
/// that IS named now, so the list cannot quietly outlive the gap it records —
/// without that it would only ever grow, and a baseline nobody prunes stops
/// being a record and becomes a permission.
const uncoveredBridges = <String>{
  'AsciiCodec',
  'Capability',
  'Codec',
  'Comparable',
  'ConnectionTask',
  'Enum',
  'EventSink',
  'FileLock',
  'FileStat',
  'FileSystemEntity',
  'FileSystemEntityType',
  'FileSystemEvent',
  'HttpClientBasicCredentials',
  'HttpClientBearerCredentials',
  'HttpClientDigestCredentials',
  'HttpClientRequest',
  'HttpSession',
  'Isolate',
  'IsolateSpawnException',
  'Latin1Codec',
  'Match',
  'Never',
  'Null',
  'Pattern',
  'Point',
  'ProcessStartMode',
  'Random',
  'RawReceivePort',
  'RawSocketEvent',
  'ReceivePort',
  'RegExpMatch',
  'RemoteError',
  'SendPort',
  'SocketDirection',
  'SocketOption',
  'Symbol',
  'TransferableTypedData',
  'WebSocketStatus',
};

/// Floors under two emptiness assertions. A walk that registered nothing, or
/// read no test files, satisfies both — the trap `F-SCB24-2` exists for, where
/// a scan read 0 of 205 names and its guard passed.
const _minRegistered = 150;
const _minTestFiles = 50;

/// Floor under SCE115's string-argument scan. Measured 2026-09-22: 87 distinct
/// names handed to a lookup, of which 15 were pinned as uncovered. Set well
/// under that — the floor is here to catch the scan reading NOTHING, not to
/// pin the count.
const _minStringNamedBridges = 40;

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
String _codeOnly(String source) => _strip(source, blankStrings: true);

/// [source] with only its COMMENTS removed, so a call shape can be recognised
/// with its string arguments intact.
///
/// Comments still go, and for the reason [_codeOnly] gives: a header
/// discussing `bridge('Null')` is prose about the idiom, not a use of it.
String _withoutComments(String source) => _strip(source, blankStrings: false);

String _strip(String source, {required bool blankStrings}) {
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
      final start = i;
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
      if (!blankStrings) out.write(source.substring(start, i));
      continue;
    }
    out.write(quote);
    i++;
  }
  return out.toString();
}

/// The `Environment` lookups that resolve a bridge BY NAME STRING.
///
/// These are the roots; a file's own wrappers around them are derived per file
/// by [_bridgeNamesResolvedInStrings].
const _registryLookups = {
  'findBridgedClassByName',
  'findAllBridgedClassesByName',
};

/// Names this source hands to a registry lookup as a string literal.
///
/// SCE115. [_codeOnly] blanks string literals, for the reason its own doc
/// gives — `Null` is a registered bridge AND an English word, so prose about
/// null made it read as covered. But THIS TREE'S REGISTRATION-LEVEL TESTS
/// ADDRESS BRIDGES BY NAME STRING:
///
///     BridgedClass bridge(String name) => env.findBridgedClassByName(name)!;
///     … bridge('RandomAccessFile').methods['writeFromSync']!(…)
///
/// so a test that genuinely drives a bridge named it only inside a string, the
/// blanking removed it, and the bridge read as uncovered. That is the error
/// SCD64 fixed, running the other way: the safe direction, because a name
/// reading as uncovered fails loudly rather than granting permission — but it
/// made the pinned set overstate the gap, and it meant the ratchet only ever
/// moved by accident. Every name that had come off did so incidentally:
/// `FileMode` because somebody happened to write `FileMode.write`,
/// `HttpResponse` and `HttpConnectionInfo` because they appear in
/// `isA<HttpResponse>()` type positions.
///
/// THE RULE IS ONE RECOGNISED CALL SHAPE, NOT A LOOSER STRIPPER. Blanking
/// strings stays load-bearing: `Match`, `Pattern`, `Enum`, `Exception`,
/// `Never`, `Symbol` and `Sink` are all registered bridge names that occur in
/// ordinary prose and in assertion messages.
///
/// THE WRAPPERS ARE DERIVED, NOT LISTED, and that distinction is the design. A
/// hard-coded `bridge|bridgeOf|bridgeNamed` list is a second baseline nobody
/// would prune — the next file inventing `theBridge` would silently stop
/// counting. Instead a local `BridgedClass f(String …)` whose BODY reaches a
/// registry lookup is taken as an alias for one, which is read from the source
/// and cannot drift away from it.
///
/// It also draws the line that matters. Several files declare
/// `BridgedClass marker(String name) => BridgedClass(nativeType: Object, name:
/// name)`, which CONSTRUCTS a synthetic bridge for an ambiguity test rather
/// than resolving a registered one. `marker('Stdin')` must not claim coverage
/// of the real `Stdin` bridge — a test that makes up a same-named fake has
/// exercised nothing. Resolving reads the registry; constructing does not, and
/// the body says which.
Set<String> _bridgeNamesResolvedInStrings(String source) {
  final resolvers = {..._registryLookups};

  // A local wrapper: `BridgedClass <name>(String …` whose body reaches a
  // lookup. Both body shapes occur — `=> env.findBridgedClassByName(name)!;`
  // and a block that asserts before returning.
  final declaration = RegExp(r'\bBridgedClass\s+(\w+)\s*\(\s*String\b');
  for (final match in declaration.allMatches(source)) {
    final body = _declarationBody(source, match.end);
    if (body != null && _registryLookups.any(body.contains)) {
      resolvers.add(match.group(1)!);
    }
  }

  const ident = r'[A-Za-z_$][\w$]*';
  final named = <String>{};
  for (final resolver in resolvers) {
    final call = RegExp(
      '\\b${RegExp.escape(resolver)}\\s*\\(\\s*'
      "(?:'($ident)'|\"($ident)\")",
    );
    for (final match in call.allMatches(source)) {
      named.add(match.group(1) ?? match.group(2)!);
    }
  }
  return named;
}

/// The body of the declaration whose parameter list starts at [from], or null
/// when neither body shape is found.
///
/// A lexer again, for the reason [_codeOnly] gives: this package has no
/// analyzer to spend. It scans past the parameter list, then takes either the
/// `=>` expression up to its `;` or the braced block up to its matching `}`.
String? _declarationBody(String source, int from) {
  var i = source.indexOf(')', from);
  if (i == -1) return null;
  i++;
  while (i < source.length && source[i].trim().isEmpty) {
    i++;
  }
  if (i >= source.length) return null;
  if (source.startsWith('=>', i)) {
    final end = source.indexOf(';', i);
    return end == -1 ? source.substring(i) : source.substring(i, end);
  }
  if (source[i] != '{') return null;
  var depth = 0;
  final start = i;
  for (; i < source.length; i++) {
    if (source[i] == '{') depth++;
    if (source[i] == '}') {
      depth--;
      if (depth == 0) return source.substring(start, i + 1);
    }
  }
  return null;
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
  //   * THIS FILE. `uncoveredBridges` below names every pinned bridge, so
  //     counting it makes every one of them read as covered and F-SCD58-3
  //     reports the entire baseline as stale on the first run. It did.
  //
  // The second is the same trap as the first, one level in: a list ABOUT the
  // gap is not coverage OF it.
  var selfSeen = false;
  var generatedSeen = false;
  final sources = <String>[];
  final namedInStrings = <String>{};
  for (final file in testFiles) {
    if (file.path.endsWith('scd58_bridge_coverage_baseline_test.dart')) {
      selfSeen = true;
      continue;
    }
    final text = file.readAsStringSync();
    final head = text.split('\n').take(3).join('\n');
    if (head.contains('GENERATED')) {
      generatedSeen = true;
      continue;
    }
    sources.add(_codeOnly(text));
    namedInStrings.addAll(
      _bridgeNamesResolvedInStrings(_withoutComments(text)),
    );
  }

  bool isNamed(String bridge) {
    if (namedInStrings.contains(bridge)) return true;
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
          'otherwise its own test data counts as coverage. F-SCD58-3 reports '
          'the consequence; this is the cause.',
    );
    // The generated-file skip gets the same treatment, and for a sharper
    // reason: it currently fires NOTHING (see the matrix), so nothing else
    // would notice the file being renamed, moved or losing its GENERATED
    // header. Asserting the skip matched something is the difference between
    // an inert guard that is known to be inert and one nobody has measured.
    expect(
      generatedSeen,
      isTrue,
      reason:
          'No test file declared GENERATED in its first three lines, so the '
          'generated-file skip matched nothing. `stdlib_member_baseline.dart` '
          'is the file it exists for — if it was renamed or regenerated '
          'without the header, say so here.',
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
    // SCE115's half of the scan needs its own floor, and for a reason the two
    // above do not cover: it can fail SILENTLY. A regex that stops matching —
    // the lookup renamed, the wrapper written in a shape the body scan misses
    // — yields an empty set, every string-named bridge reads as uncovered
    // again, and the only symptom is F-SCD58-2 reporting names that ARE
    // covered. That reads as a coverage finding rather than as a broken scan.
    expect(
      namedInStrings.length,
      greaterThanOrEqualTo(_minStringNamedBridges),
      reason:
          'Only ${namedInStrings.length} names were found as string '
          'arguments to a registry lookup. The recognised call shapes are '
          '$_registryLookups plus each file\'s own '
          '`BridgedClass f(String …)` wrappers around them — see '
          '_bridgeNamesResolvedInStrings. If a lookup was renamed, rename it '
          'there too.',
    );
  });

  // EACH ROW OBSERVED, by breaking the thing named. RE-MEASURED 2026-09-22
  // against the 38-name set, because two rows had gone stale and one of them
  // was stale in a way that mattered:
  //
  //   | Injected fault                                     | Fires        |
  //   | -------------------------------------------------- | ------------ |
  //   | a baselined name removed from the list              | 2, x1        |
  //   | a baselined name given a mention in a test          | 3, x1        |
  //   | _codeOnly dropped (comments and strings counted)    | 3, x28       |
  //   | the SELF exclusion dropped                          | 1, and 3 x1  |
  //   | this file renamed without updating the skip         | 1, and 3 x1  |
  //   | the generated file COUNTED (its `continue` removed) | NOTHING      |
  //   | the generated-file skip removed altogether          | 1            |
  //   | the GENERATED header renamed on that file           | 1            |
  //   | the string-argument scan dropped entirely           | 2, x15       |
  //   | the derived wrappers dropped (root lookups only)    | 2, x8        |
  //   | a CONSTRUCTING helper counted as a resolver         | SCE115-1     |
  //   | the string-scan floor lowered past the real count   | 1            |
  //   | the test-source walk pointed at a missing directory | 1            |
  //
  // THE GENERATED-FILE EXCLUSION CHANGES NO COVERAGE ANSWER, and the header
  // used to say it fired x63 — the row above is the measurement: let the
  // generated file be counted and every test still passes. It stopped mattering when SCD64 added [_codeOnly]: the
  // `auditedClasses` set that made the whole scan green is a list of STRING
  // LITERALS, and blanking strings already removes it. The claim outlived the
  // mechanism by five days without anybody noticing, because a row in a matrix
  // is believed rather than run.
  //
  // IT IS KEPT ANYWAY, for a reason SCE115 supplies rather than sentiment:
  // strings are no longer uniformly blank. [_bridgeNamesResolvedInStrings]
  // reads string arguments, and a widening of that path — a third recognised
  // shape, a looser wrapper rule — is exactly what would let a generated list
  // of names count again. So the exclusion is now asserted to MATCH something
  // (`generatedSeen`, beside `selfSeen`) instead of being assumed to matter.
  // An inert guard that is known to be inert is fine; one believed to be
  // load-bearing is not. That is what the last two rows are: the skip can no
  // longer be deleted, nor the header it keys on renamed, without F-SCD58-1
  // saying so.
  //
  // THE SELF EXCLUSION HAD GONE STALE THE SAME WAY — x63 then, x1 now, for the
  // same reason: `uncoveredBridges` is a list of strings. SCE115 gave it a new
  // reason to exist, which is why the row is not zero: F-SCE115-1's fixtures
  // contain `BridgedClass bridge(String name)` and `bridge('Null')` INSIDE
  // string literals, and [_withoutComments] keeps those — so this file would
  // claim `Null` from its own test data. The trap moved rather than closing.
  //
  // The rename row fires 1 AND 3, which was not the original prediction:
  // F-SCD58-1's `selfSeen` check names the cause, and F-SCD58-3 then reports
  // the consequence. Read the first.
  //
  // The `_codeOnly` row is how the stripper was added at all: SCD64's test
  // asserts the SDK message 'Null check operator used on a null value', the
  // word `Null` is a registered bridge, and the guard reported it as covered.
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

  // SCE115's mechanism, asked directly rather than through the corpus.
  //
  // The corpus answer is a good check that the rule WORKS — fifteen names came
  // off — but it cannot show the rule stops where it should, because only one
  // name is passed to a constructing helper at all (`marker('Stdin')`) and
  // that name is covered independently. A rule whose discrimination is never
  // exercised is a rule nobody has tested.
  test('F-SCE115-1: a registry lookup names a bridge and a constructor does '
      'not [2026-09-22] (PASS)', () {
    // The idiom, through the Environment call itself.
    expect(
      _bridgeNamesResolvedInStrings(
        "env.findBridgedClassByName('RandomAccessFile')!",
      ),
      {'RandomAccessFile'},
    );
    // …and through a local wrapper, in both body shapes. The wrapper is
    // DERIVED from its body, so a file inventing its own name still counts.
    expect(
      _bridgeNamesResolvedInStrings('''
        BridgedClass theBridge(String name) => env.findBridgedClassByName(name)!;
        theBridge('Stdout').methods['write'];
      '''),
      {'Stdout'},
    );
    expect(
      _bridgeNamesResolvedInStrings('''
        BridgedClass bridge(String name) {
          final found = env.findBridgedClassByName(name);
          expect(found, isNotNull);
          return found!;
        }
        bridge('Utf8Codec');
      '''),
      {'Utf8Codec'},
    );

    // THE LINE THAT MATTERS: a helper that CONSTRUCTS a same-named bridge has
    // exercised nothing registered. Several files declare exactly this to
    // build synthetic bridges for ambiguity tests.
    expect(
      _bridgeNamesResolvedInStrings('''
        BridgedClass marker(String name) =>
            BridgedClass(nativeType: Object, name: name);
        marker('Stdin');
      '''),
      isEmpty,
    );

    // Prose still does not count — SCD64's rule is untouched. A header that
    // shows the idiom is talking about it.
    expect(
      _bridgeNamesResolvedInStrings(
        _withoutComments("// … use bridge('Null') to reach it\nvar x = 1;"),
      ),
      isEmpty,
    );
    // Nor does an ordinary string that happens to be a bridge name.
    expect(
      _bridgeNamesResolvedInStrings(
        "expect(e.message, 'Null check operator used on a null value');",
      ),
      isEmpty,
    );
  });
}
