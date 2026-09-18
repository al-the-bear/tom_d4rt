// REPO-WIDE GUARD (tom_d4rt) — both trees accept a bridged tear-off wherever a callback is taken.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
/// SCD35: a method torn off a bridged instance must be usable wherever a
/// function is expected.
///
/// The reproduction is one line of idiomatic Dart:
///
/// ```dart
/// final seen = <int>[]; stream.listen(seen.add);
/// ```
///
/// `seen.add` tears off a method from a bridged `List`, producing a
/// `BridgedMethodCallable`. Sixty-two stdlib bridge files then cast their
/// callback argument to `InterpretedFunction`, which a bridged callable is not
/// a subtype of, so the cast threw — `type 'BridgedMethodCallable' is not a
/// subtype of type 'InterpretedFunction?'`. Adapters that guarded with
/// `is! InterpretedFunction` instead reported `requires a Function`, which is
/// the same defect wearing a more confusing message: the argument *is* a
/// function.
///
/// `Callable` is the supertype both kinds already implement, and two files
/// (`core/list.dart`'s Bug-95 fix, `collection/unmodifiable_list_view.dart`)
/// had converged on it independently. The fix finishes that job across the
/// stdlib rather than adding a third case at each site.
///
/// ## Every case here is the BARE tear-off, on purpose
///
/// The SCC11 tests that first hit this worked around it by wrapping —
/// `stream.listen((v) => seen.add(v))` — and a wrapped call passes just as
/// well with the defect present as without it. An assertion written that way
/// measures nothing. The wrapped form appears exactly once below, labelled as
/// a control, to show the workaround still works and is no longer needed.
///
/// F-SCD35-9 is the ratchet: the surface of this bug grew with the bridge
/// corpus, because every newly bridged member is another tear-off and every
/// newly written adapter is another chance to narrow to `InterpretedFunction`.
/// A behavioural test covers the members it names; the scan covers the ones
/// nobody has written yet.
///
/// ## The generated half — F-SCD35-13 and F-SCD35-14
///
/// F-SCD35-9 scans `stdlib/` in the two interpreter trees. Those are the
/// HAND-WRITTEN adapters, and they are only part of the surface: the generator
/// emits a callback call for every bridged member that takes one, across 207
/// `.b.dart` files in this repository. One wrong template there multiplies.
///
/// The generator has been right for months — it emits
/// `D4.callInterpreterCallback`, which dispatches on `Callable` — and 201 of
/// the 207 files show it. The remaining six were generated on 2026-02-07,
/// before the generator carried a version stamp at all, and still read
/// `(xRaw as InterpretedFunction).call(...)`. They are `tom_d4rt_dcli`'s three
/// library bridges and `tom_dcli_exec`'s identical three.
///
/// They are recorded as DEBT WITH A COUNT, not exempted by path. The count is
/// what lets F-SCD35-14 fail in both directions: a regeneration that used a
/// generator still emitting the narrowing would make the number grow, and a
/// regeneration that fixed the file would make it zero — which is good news
/// and has to be recorded, or the entry stops describing debt and starts
/// granting permission. The remedy is a REGENERATION of those two packages,
/// not an edit — a `.b.dart` says "do not edit" on its first line — and it is
/// blocked on a generator/analyzer resolution rather than on anybody's time.
///
/// EACH OF THE TWO HAS BEEN SEEN TO FAIL:
///
///   | Injected fault                                        | Fires  |
///   | ----------------------------------------------------- | ------ |
///   | a narrowing added to a clean generated bridge          | 13     |
///   | a recorded count changed so it no longer matches disk  | 14     |
///   | the repo root pointed somewhere with no `.b.dart`      | 13, 14 |
///
/// The third row is the anti-vacuity check doing its job: both cases are
/// emptiness assertions over a walk, and a walk that found no generated
/// bridges finds no narrowings either.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'sibling_trees.dart';

const _libUri = 'package:scd35/scd35.dart';

/// A bridged class with a method that takes a callback, so the "passed to a
/// bridged-function parameter" half does not depend on which stdlib member
/// happens to be wired up today.
class Relay {
  Relay();
  final List<Object?> received = [];
}

D4rt _interpreter() {
  final interpreter = D4rt();
  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: Relay,
      name: 'Relay',
      constructors: {'': (visitor, positional, named) => Relay()},
      methods: {
        // Takes a callback and invokes it. The adapter accepts any Callable,
        // which is the contract this todo establishes for bridge authors.
        'pump': (visitor, target, positional, named, typeArgs) {
          final callback = positional[0] as Callable;
          for (final v in [1, 2, 3]) {
            callback.call(visitor, [v], const {});
          }
          return null;
        },
      },
      getters: {'received': (visitor, target) => (target as Relay).received},
    ),
    _libUri,
    sourceUri: _libUri,
  );
  return interpreter;
}

/// Runs [source] and returns its result, awaiting it when the script is async.
Future<Object?> _run(String source, {bool withRelay = false}) async {
  final interpreter = withRelay ? _interpreter() : D4rt();
  final result = interpreter.execute(
    source: withRelay ? "import '$_libUri';\n\n$source" : source,
  );
  return result is Future ? await result : result;
}

/// Every `InterpretedFunction` type test or cast in a tree's stdlib, which
/// after SCD35 should be none: the stdlib coerces script-supplied callbacks,
/// and a callback is a `Callable`.
List<String> _narrowingSites(String stdlibRoot) {
  final narrowing = RegExp(r'\b(?:as|is|is!)\s+InterpretedFunction\b');
  final hits = <String>[];
  for (final entity in Directory(stdlibRoot).listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final lines = entity.readAsStringSync().split('\n');
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmed = line.trimLeft();
      if (trimmed.startsWith('//')) continue; // prose may name the class
      // `errorHandlerArgs` probes for the one capability only an interpreted
      // function has -- how many positional parameters it declares -- to decide
      // whether an error handler takes a stack trace. That is a capability
      // probe, not a coercion gate: the argument is already typed `Callable`
      // and a bridged callable takes the other branch rather than being
      // rejected. Exempted by shape rather than by file, so a plain narrowing
      // cast added to that same file still fails this case.
      if (line.contains('maxPositionalArity')) continue;
      if (narrowing.hasMatch(line)) {
        hits.add('${entity.path.split('/stdlib/').last}:${i + 1}');
      }
    }
  }
  hits.sort();
  return hits;
}

/// Every generated bridge in the repository that calls a callback through an
/// `InterpretedFunction` cast, keyed by repo-relative path with its site count.
///
/// SEPARATE FROM [_narrowingSites] because the remedy is different. A narrowing
/// in `stdlib/` is hand-written and is fixed by editing it; a narrowing in a
/// `.b.dart` is the GENERATOR's output and the file says so on its first line —
/// it is fixed by regenerating, and editing it would be overwritten.
Map<String, int> _generatedNarrowingSites(String repoRoot) {
  final narrowing = RegExp(r'\b(?:as|is|is!)\s+InterpretedFunction\b');
  final out = <String, int>{};
  for (final entity in Directory(repoRoot).listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.b.dart')) continue;
    var count = 0;
    for (final line in entity.readAsStringSync().split('\n')) {
      if (line.trimLeft().startsWith('//')) continue;
      if (narrowing.hasMatch(line)) count++;
    }
    if (count == 0) continue;
    out[entity.path.substring(repoRoot.length + 1)] = count;
  }
  return out;
}

/// How many `.b.dart` files the repository held on 2026-09-15. The floor is
/// well below that because its job is to separate "scanned the corpus" from
/// "scanned nothing" — a walk that found no generated bridges would satisfy
/// F-SCD35-10 by finding no narrowings either.
const _minGeneratedBridges = 150;

/// Generated bridges still carrying the pre-SCD35 narrowing, with their exact
/// site count.
///
/// THESE ARE NOT EXEMPTIONS, THEY ARE DEBT. Every one was generated on
/// 2026-02-07 — before the generator was even version-stamped — and carries
/// `(xRaw as InterpretedFunction).call(...)`, which throws a `CastError` when a
/// script passes a bridged tear-off such as `seen.add`. The other 201 generated
/// bridges in the repository route through `D4.callInterpreterCallback`, which
/// accepts `Callable`, so the generator itself has been right for months.
///
/// The count is pinned rather than the path, for the reason SCD49 pins regions
/// rather than files: a pinned path would let the debt grow silently, and the
/// point of recording it is that it is finite and shrinking.
///
/// The remedy is to regenerate those two packages, not to edit here. A
/// `.b.dart` says "do not edit" on its first line and means it.
///
/// EMPTY SINCE 2026-09-18, and the way it emptied is worth recording because
/// it is not the way the paragraph above predicted. The six files were not
/// regenerated: SCE30 found them ORPHANED — committed generated files that no
/// generator run writes any more — and deleted them. So the debt went away
/// with its carriers rather than being paid, and the narrowing sites went with
/// it. The register is kept declared rather than removed: F-SCD35-13 reads it
/// as the allow-list of known-narrowing files, so an empty map is what makes
/// any NEW one a failure, and F-SCD35-14 is the ratchet over it.
const _staleGeneratedBridges = <String, int>{};

void main() {
  // SCD158: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage('tom_d4rt', subject: 'both interpreter trees under lib/src');

  group('SCD35: a bridged tear-off is accepted wherever a function is', () {
    group('passed to a bridged-function parameter', () {
      test('F-SCD35-1: `stream.listen(seen.add)` — the reported case '
          '[2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Stream.fromIterable([1, 2, 3]).listen(seen.add).asFuture();
  return seen.join(',');
}
'''),
          '1,2,3',
        );
      });

      test('F-SCD35-2: `future.then(seen.add)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Future.value(7).then(seen.add);
  return seen.join(',');
}
'''),
          '7',
        );
      });

      test('F-SCD35-3: `stream.map(buffer.write)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final b = StringBuffer();
  await Stream.fromIterable([1, 2]).map(b.write).toList();
  return b.toString();
}
'''),
          '12',
        );
      });

      test('F-SCD35-4: `stream.where(seen.contains)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final allowed = <int>{1, 3};
  final r = await Stream.fromIterable([1, 2, 3]).where(allowed.contains).toList();
  return r.join(',');
}
'''),
          '1,3',
        );
      });

      test('F-SCD35-5: a tear-off reaches a bridged method on a class the '
          'stdlib knows nothing about [2026-09-12]', () async {
        // Independent of which stdlib members happen to be wired up: this is
        // the contract a bridge author writing `as Callable` gets.
        expect(
          await _run('''
main() {
  final seen = <int>[];
  Relay().pump(seen.add);
  return seen.join(',');
}
''', withRelay: true),
          '1,2,3',
        );
      });
    });

    group('passed to an interpreted-function parameter', () {
      test('F-SCD35-6: a declared `void Function(int)` parameter '
          '[2026-09-12]', () async {
        expect(
          await _run('''
void apply(void Function(int) f) {
  f(1);
  f(2);
}

main() {
  final seen = <int>[];
  apply(seen.add);
  return seen.join(',');
}
'''),
          '1,2',
        );
      });

      test(
        'F-SCD35-7: stored in a typed local, then called [2026-09-12]',
        () async {
          expect(
            await _run('''
main() {
  final seen = <int>[];
  void Function(int) f = seen.add;
  f(9);
  return seen.join(',');
}
'''),
            '9',
          );
        },
      );
    });

    group('error handlers, where the widening had to make a choice', () {
      // `errorHandlerArgs` decides whether to hand a handler the stack trace by
      // reading `maxPositionalArity`, which only an interpreted function can
      // answer. Widening its parameter to `Callable` meant deciding what a
      // bridged callable gets. These three cases pin that decision.
      const controller = """
  final got = <Object?>[];
  final c = StreamController();
  c.addError(StateError('x'));
  c.close();
""";

      test('F-SCD35-10: an interpreted `(e, st)` handler still receives the '
          'trace [2026-09-12]', () async {
        // The regression guard on the introspection. Losing this would make
        // every two-parameter error handler silently trace-less.
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: (e, st) {
    got.add(st == null ? 'no-trace' : 'trace');
  });
  await Future.delayed(Duration(milliseconds: 50));
  return got.join(',');
}
"""),
          'trace',
        );
      });

      test('F-SCD35-11: an interpreted `(e)` handler still receives one '
          'argument [2026-09-12]', () async {
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: (e) { got.add('one'); });
  await Future.delayed(Duration(milliseconds: 50));
  return got.join(',');
}
"""),
          'one',
        );
      });

      test('F-SCD35-12: a bridged tear-off as `onError` is called with the '
          'error alone [2026-09-12]', () async {
        // A bridged callable carries no parameter metadata to introspect --
        // `BridgedMethodCallable.arity` is a hardcoded 0 because the adapter
        // validates arity itself. The single-argument form is chosen because
        // `(error)` is the shape every SDK error handler accepts, whereas
        // passing a second argument to a one-parameter tear-off such as
        // `got.add` fails inside the adapter.
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: got.add);
  await Future.delayed(Duration(milliseconds: 50));
  return got.length;
}
"""),
          1,
        );
      });
    });

    test(
      'F-SCD35-8: CONTROL — the wrapped form still works [2026-09-12]',
      () async {
        // The SCC11 workaround. It passed before the fix too, which is exactly
        // why no other case in this file is written this way.
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Stream.fromIterable([1, 2, 3]).listen((v) => seen.add(v)).asFuture();
  return seen.join(',');
}
'''),
          '1,2,3',
        );
      },
    );

    test('F-SCD35-9: no stdlib bridge narrows a callback argument to '
        '`InterpretedFunction`, in either twin [2026-09-12]', () {
      final d4rtRoot = Directory.current.path.endsWith('tom_d4rt')
          ? Directory.current.path
          : '${Directory.current.path}/tom_d4rt';
      final roots = {
        'tom_d4rt': '$d4rtRoot/lib/src/stdlib',
        'tom_d4rt_ast': Directory(
          '$d4rtRoot/../tom_d4rt_ast/lib/src/runtime/stdlib',
        ).absolute.path,
      };

      for (final entry in roots.entries) {
        expect(
          Directory(entry.value).existsSync(),
          isTrue,
          reason:
              '${entry.value} does not exist, so this case would pass having '
              'scanned nothing. Fix the path, not the assertion.',
        );
        expect(
          _narrowingSites(entry.value),
          isEmpty,
          reason:
              'A stdlib bridge coercing a script-supplied callback must accept '
              '`Callable`. Narrowing to `InterpretedFunction` rejects a bridged '
              'tear-off such as `seen.add`, which is a function the script is '
              'entitled to pass. Found in ${entry.key}.',
        );
      }
    });

    test('F-SCD35-13: no GENERATED bridge narrows a callback to '
        '`InterpretedFunction`, outside the recorded debt [2026-09-15] '
        '(PASS)', () {
      // THE GAP F-SCD35-9 LEAVES, and it is the one this bug was reported
      // through. That case scans `stdlib/` in the two interpreter trees —
      // hand-written adapters. It says nothing about the 207 `.b.dart` files
      // the generator produces, and 6 of them still carry the pre-SCD35 shape.
      //
      // The surface matters more here than in stdlib, not less: a generated
      // bridge is emitted once per bridged member, so one wrong template
      // multiplies. The 201 clean files route through
      // `D4.callInterpreterCallback`, which accepts `Callable`.
      final repoRoot = Directory(_repoRoot()).absolute.path;
      final all = Directory(repoRoot)
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.b.dart'))
          .length;
      expect(
        all,
        greaterThanOrEqualTo(_minGeneratedBridges),
        reason:
            'Found only $all generated bridges under $repoRoot. That is not a '
            'finding about the generator — the walk did not run.',
      );

      final found = _generatedNarrowingSites(repoRoot);
      final unrecorded =
          found.keys
              .where((f) => !_staleGeneratedBridges.containsKey(f))
              .toList()
            ..sort();

      expect(
        unrecorded,
        isEmpty,
        reason:
            'These generated bridges call a callback through an '
            '`InterpretedFunction` cast:\n'
            '${unrecorded.map((f) => '  $f (${found[f]} sites)').join('\n')}\n\n'
            'A bridged tear-off such as `seen.add` is a '
            '`BridgedMethodCallable`, not an `InterpretedFunction`, so the '
            'cast throws and the script is told its valid Dart is not a '
            'function. Fix the GENERATOR — emit '
            '`D4.callInterpreterCallback`, which accepts `Callable` — and '
            'regenerate. Do not edit the `.b.dart`; its first line says so.',
      );
    });

    test('F-SCD35-14: the recorded generated-bridge debt has not grown, and '
        'nothing paid stays on the list [2026-09-15] (PASS)', () {
      // The ratchet, in both directions. Pinning the COUNT rather than the
      // path is what makes the first direction possible: a pinned path would
      // let a regeneration of one member reintroduce ten narrowings in a file
      // that is already on the list, and nothing would say so.
      final found = _generatedNarrowingSites(
        Directory(_repoRoot()).absolute.path,
      );
      final wrong = <String>[];
      for (final entry in _staleGeneratedBridges.entries) {
        final actual = found[entry.key] ?? 0;
        if (actual == entry.value) continue;
        wrong.add(
          '  ${entry.key}: recorded ${entry.value}, found $actual'
          '${actual == 0 ? ' — regenerated; delete the entry' : ''}',
        );
      }

      expect(
        wrong,
        isEmpty,
        reason:
            'The recorded debt no longer matches what is on disk:\n'
            '${wrong.join('\n')}\n\n'
            'A count that grew means a regeneration used a generator that '
            'still emits the narrowing — fix the generator first. A count of '
            'zero is good news and has to be recorded: left on the list, the '
            'entry stops describing debt and starts granting permission.',
      );
    });
  });
}

/// The `tom_ai/d4rt` checkout root, from wherever the suite was started.
///
/// The repo holds every D4rt package as a sibling of `tom_d4rt`, so the parent
/// is the subject for anything scanning across packages.
String _repoRoot() => Directory.current.path.endsWith('tom_d4rt')
    ? '${Directory.current.path}/..'
    : Directory.current.path;
