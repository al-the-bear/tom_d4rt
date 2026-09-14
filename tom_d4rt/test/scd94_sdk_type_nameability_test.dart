// REPO-WIDE GUARD (tom_d4rt) — every SDK type either tree can raise is nameable in an `on` clause.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
import 'dart:io';

import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCD94 — every SDK type d4rt can raise must be nameable in an `on` clause.
///
/// SCC30 answered its own open question empirically, and the answer exposed a
/// hazard bigger than the question. Applying the operator fix WITHOUT
/// registering `IntegerDivisionByZeroException` as a `BridgedClass` gave 19 of
/// 21 passing, and the two failures were exactly the two by-name cases. The
/// registration was required — but the way it fails when missing is the finding
/// this file exists for.
///
/// AN `on` CLAUSE NAMING AN UNREGISTERED TYPE DOES NOT ERROR. It never matches.
/// The script falls through to the next clause, or to the bare `catch`, or out
/// of the `try` entirely, and takes a branch it never meant to take. Measured
/// here as F-SCD94-1, -2 and -3, because a hazard nobody has seen fire reads as
/// theoretical.
///
/// **Real Dart makes this a compile error.** `on NotARegisteredError` is
/// `non_type_in_catch_clause`: "The name 'NotARegisteredError' isn't a type and
/// can't be used in an on-catch clause." So the divergence runs in the most
/// dangerous direction available — Dart refuses to build the program, d4rt runs
/// a different branch of it and says nothing. Making d4rt refuse it too is the
/// real fix and is filed separately; this file is the guard that keeps the
/// registered set honest in the meantime, and it stays useful afterwards
/// because it is the only thing that checks the set is COMPLETE rather than
/// merely self-consistent.
///
/// WHY THE ASSERTIONS ARE `try`/`on` AND NOT `isAssignable`
///
/// A bridge can be registered and still not be nameable. Resolution goes
/// through the environment's bridge lookup BY NAME, so a class registered under
/// a different name, or defined in a library the script has not imported,
/// resolves to nothing while `isAssignable` looks perfectly healthy. Only
/// executing the `try`/`on` proves the path — and asserting the clause is
/// ENTERED is the only assertion that cannot pass vacuously, since an
/// unregistered type makes the clause fall through rather than fail.
///
/// THE DIRECTION MATTERS, AND IT IS THE OPPOSITE OF SCC24'S
///
/// The native-name coverage guard starts from a registration and sweeps forward
/// to check its getters are reachable. This starts from a RAISE SITE and sweeps
/// back. The blind spots do not overlap: SCC24 cannot see a type that is never
/// registered at all, because it only walks what is already in the map.
///
/// WHAT IS IN SCOPE
///
/// The `dart:core` and `dart:async` error hierarchy — the types the interpreter
/// itself raises and the ones the core bridges raise. The `dart:io` and
/// `dart:isolate` types (`SocketException`, `IsolateSpawnException`, …) are
/// registered in their own hierarchies and are raised by NATIVE callees, which
/// `sdk_errors.dart` notes were never the problem: a native throw arrives as
/// itself. They also need an import and a permission grant to reach, which
/// would make this file's failures depend on the sandbox rather than on the
/// registration. F-SCD94-7 therefore ratchets against `ErrorHierarchyCore`
/// specifically, so the file cannot fall behind the hierarchy it guards.
void main() {
  /// The value of running [body] inside a `try` whose only typed clause names
  /// [typeName] — `'CAUGHT'` when the clause is entered, `'FELL-THROUGH: …'`
  /// when it is inert, `'NO THROW'` when [body] did not raise at all.
  ///
  /// The bare `catch` is what makes a failure legible: without it an inert
  /// clause reports as an escaped exception and reads like a bug in the
  /// operation rather than in the registration.
  String onClause(String typeName, String body) =>
      execute('''
            main() {
              try { $body }
              on $typeName { return 'CAUGHT'; }
              catch (e) { return 'FELL-THROUGH: ' + e.runtimeType.toString(); }
              return 'NO THROW';
            }
          ''')
          as String;

  group('SCD94: an SDK type d4rt raises is nameable in an `on` clause', () {
    // ------------------------------------------------------------------
    // The hazard itself. Every positive case below is only meaningful
    // because these three show what a MISSING registration looks like.

    test('F-SCD94-1: an `on` clause naming an unregistered type falls through '
        'silently [2026-09-14]', () {
      // No error, no warning, nothing in the output that says the clause was
      // inert. Real Dart refuses to compile this.
      expect(
        onClause('NotARegisteredError', 'var l = <int>[]; return l.first;'),
        startsWith('FELL-THROUGH'),
      );
    });

    test('F-SCD94-2: an inert clause lets a LATER clause take the branch '
        '[2026-09-14]', () {
      // The shape that makes this worse than a crash. The script runs, returns
      // a value, and the value came from a handler the author did not intend
      // to reach.
      expect(
        execute('''
          main() {
            try { var l = <int>[]; return l.first; }
            on NotARegisteredError { return 'first'; }
            on Error { return 'second'; }
            return 'none';
          }
        '''),
        'second',
      );
    });

    test('F-SCD94-3: with no other clause the exception escapes the try '
        '[2026-09-14]', () {
      expect(
        () => execute('''
          main() {
            try { var l = <int>[]; return l.first; }
            on NotARegisteredError { return 'CAUGHT'; }
            return 'NO THROW';
          }
        '''),
        throwsA(isA<StateError>()),
      );
    });

    // ------------------------------------------------------------------
    // Types the INTERPRETER or a core bridge raises from a real operation.
    // This is the strongest form of the assertion: the raise is not staged.

    test('F-SCD94-4: every type raised by a real operation is catchable by '
        'name [2026-09-14]', () {
      final failures = <String>[];
      _raisedByOperation.forEach((typeName, body) {
        final result = onClause(typeName, body);
        if (result != 'CAUGHT') failures.add('  $typeName -> $result');
      });
      expect(
        failures,
        isEmpty,
        reason:
            'These types are raised by d4rt but cannot be named in an `on` '
            'clause:\n${failures.join('\n')}\n\n'
            'A type reaches an `on` clause through the environment\'s bridge '
            'lookup BY NAME. Register it as a `BridgedClass` in '
            '`lib/src/stdlib/core/error.dart` AND give it a supertype-chain '
            'entry in `ErrorHierarchyCore.register()` — both, in BOTH trees. '
            'Until then the clause is inert and the script silently takes '
            'another branch (F-SCD94-1).',
      );
    });

    test('F-SCD94-5: every type a script can construct is catchable by name '
        '[2026-09-14]', () {
      // The types with no operation that raises them here. `IndexError` is the
      // interesting one: `l[5]` raises a plain `RangeError` in real Dart and in
      // d4rt (see `sdk_errors.dart`, which explains why raising `IndexError`
      // would make d4rt strictly MORE catchable than the platform), so its
      // nameability has to be proved by constructing it. A type a script can
      // neither raise nor construct is not nameable in any useful sense.
      final failures = <String>[];
      _constructible.forEach((typeName, body) {
        final result = onClause(typeName, body);
        if (result != 'CAUGHT') failures.add('  $typeName -> $result');
      });
      expect(failures, isEmpty, reason: failures.join('\n'));
    });

    test('F-SCD94-6: the supertype chain is walked, not just the exact name '
        '[2026-09-14]', () {
      // `ErrorHierarchyCore.register()` is the second half of the contract, and
      // a registration with no hierarchy entry passes F-SCD94-4 while leaving
      // `on Error` inert for that type. These are the edges that entry declares.
      expect(onClause('Error', 'var l = <int>[]; return l.first;'), 'CAUGHT');
      expect(
        onClause('ArgumentError', 'var l = <int>[1]; return l[5];'),
        'CAUGHT',
      );
      expect(
        onClause('Error', 'var a = 1; var b = 2.0; return a & b;'),
        'CAUGHT',
      );
      // IntegerDivisionByZeroException implements BOTH UnsupportedError and
      // Exception, so both names must reach it — the reason its hierarchy entry
      // lists two parents rather than an Error chain alone.
      const divByZero = 'var a = 1; var z = 0; return a ~/ z;';
      expect(onClause('UnsupportedError', divByZero), 'CAUGHT');
      expect(onClause('Exception', divByZero), 'CAUGHT');
      expect(onClause('Error', divByZero), 'CAUGHT');
    });

    // ------------------------------------------------------------------
    // The ratchets. Without these the tables above are a snapshot that goes
    // stale the first time somebody registers a type.

    test('F-SCD94-7: every type in ErrorHierarchyCore has a case above '
        '[2026-09-14]', () {
      final registered = _errorHierarchyNames(_refErrorSource());
      expect(
        registered,
        isNotEmpty,
        reason:
            'Read no names out of `ErrorHierarchyCore.register()`. The scan is '
            'this guard\'s only link to the registration, so an empty result '
            'is a broken test rather than a clean one.',
      );
      final covered = {..._raisedByOperation.keys, ..._constructible.keys};
      final uncovered = registered.difference(covered).toList()..sort();
      expect(
        uncovered,
        isEmpty,
        reason:
            'These types are in `ErrorHierarchyCore.register()` but no case in '
            'this file proves a script can name them:\n'
            '${uncovered.map((n) => '  $n').join('\n')}\n\n'
            'Add each to `_raisedByOperation` if an operation raises it, or to '
            '`_constructible` otherwise. Registering a type without proving it '
            'is nameable is how the contract this file guards went unchecked '
            'in the first place.',
      );
    });

    test('F-SCD94-8: both trees register the same error types [2026-09-14]', () {
      // A type registered in one tree only is exactly the silent divergence
      // this guard should refuse to allow: the analyzer-free line would run the
      // wrong branch for a script the reference line handles.
      //
      // F-SCD49-2 subsumes this today — `core/error.dart` is outside its
      // allow-list, so the two copies are already asserted code-identical. This
      // assertion is kept anyway because it names the specific contract: if
      // `error.dart` is ever allow-listed for an unrelated reason, the
      // hierarchy would stop being compared and nothing would say so.
      final ast = File(_astErrorPath);
      expect(
        ast.existsSync(),
        isTrue,
        reason:
            'The twin is a sibling checkout in the same `tom_d4rt` repository. '
            'If it is absent this comparison cannot be made, and reporting '
            'that as a pass would be worse than failing.',
      );
      expect(
        _errorHierarchyNames(ast.readAsStringSync()),
        equals(_errorHierarchyNames(_refErrorSource())),
        reason:
            'The two trees\' `ErrorHierarchyCore.register()` maps disagree. '
            'Port the missing entries; a type registered in one tree only makes '
            '`on <Type>` inert on the other, with no symptom but a wrong branch.',
      );
      expect(
        _bridgedClassNames(ast.readAsStringSync()),
        equals(_bridgedClassNames(_refErrorSource())),
        reason:
            'The two trees\' `core/error.dart` register different '
            '`BridgedClass` names. Both halves of the contract have to match, '
            'not just the hierarchy.',
      );
    });

    test('F-SCD94-9: every SDK type named in sdk_errors.dart is registered '
        '[2026-09-14]', () {
      // Closing the loop from the RAISING side. `sdk_errors.dart` is where the
      // interpreter declares which SDK types it impersonates; each one has to
      // be reachable by name or the impersonation buys nothing.
      final declared = _sdkErrorTypes(
        File(
          '${Directory.current.path}/lib/src/sdk_errors.dart',
        ).readAsStringSync(),
      );
      expect(
        declared,
        isNotEmpty,
        reason: 'Read no SDK types out of `sdk_errors.dart`.',
      );
      final registered = _errorHierarchyNames(_refErrorSource());
      final missing = declared.difference(registered).toList()..sort();
      expect(
        missing,
        isEmpty,
        reason:
            '`sdk_errors.dart` raises these SDK types but '
            '`ErrorHierarchyCore.register()` does not know them:\n'
            '${missing.map((n) => '  $n').join('\n')}\n\n'
            'The interpreter goes to the trouble of raising a value that IS a '
            '$missing — `implements` rather than `extends`, so an `on` clause '
            'matches — and then the clause cannot name it.',
      );
    });
  });
}

// ---------------------------------------------------------------------------
// The tables.

/// Types raised by a REAL operation, mapped to the smallest body that raises
/// one. Preferred over [_constructible] wherever an operation exists: a staged
/// `throw` proves the name resolves, while an operation also proves the
/// interpreter reaches that name on the path a script actually takes.
const _raisedByOperation = <String, String>{
  'Error': 'var l = <int>[]; return l.first;',
  'StateError': 'var l = <int>[]; return l.first;',
  'ArgumentError': 'var l = <int>[1]; return l[5];',
  'RangeError': 'var l = <int>[1]; return l[5];',
  'UnsupportedError': 'var a = 1; var z = 0; return a ~/ z;',
  'IntegerDivisionByZeroException': 'var a = 1; var z = 0; return a ~/ z;',
  // SCD93 stopped the hand-written guards intercepting these two.
  'NoSuchMethodError': "var s = 'x'; return -s;",
  'TypeError': 'var a = 1; var b = 2.0; return a & b;',
  'ConcurrentModificationError':
      'var l = <int>[1, 2, 3]; for (var x in l) { l.add(x); } return l;',
  'AssertionError': 'assert(false); return 1;',
  'FormatException': "return int.parse('x');",
};

/// Types with no operation in this suite that raises them, proved nameable by
/// constructing and throwing one.
const _constructible = <String, String>{
  // Real Dart's `l[5]` raises a plain RangeError, not an IndexError — so there
  // is no list access that reaches this name, by design.
  'IndexError': 'throw IndexError.withLength(5, 1);',
  'UnimplementedError': "throw UnimplementedError('x');",
  // Raised by the VM under conditions a test cannot ask for on demand.
  'StackOverflowError': 'throw StackOverflowError();',
  'OutOfMemoryError': 'throw OutOfMemoryError();',
  'Exception': "throw Exception('boom');",
};

// ---------------------------------------------------------------------------
// Source scans. Deliberately textual: importing the twin is impossible (it is a
// different package) and importing the registration would prove only that the
// map parses, not that a script can reach it.

String _refErrorSource() => File(
  '${Directory.current.path}/lib/src/stdlib/core/error.dart',
).readAsStringSync();

const _astErrorPath = '../tom_d4rt_ast/lib/src/runtime/stdlib/core/error.dart';

/// The keys of the `registerSupertypes` map in [source].
Set<String> _errorHierarchyNames(String source) {
  final start = source.indexOf('BridgedClass.registerSupertypes');
  if (start < 0) return const {};
  final open = source.indexOf('{', start);
  final close = source.indexOf('});', open);
  if (open < 0 || close < 0) return const {};
  final body = source.substring(open, close);
  return RegExp(
    "'([A-Za-z_][A-Za-z0-9_]*)':",
  ).allMatches(body).map((m) => m.group(1)!).toSet();
}

/// The `name:` of every `BridgedClass` declared in [source].
Set<String> _bridgedClassNames(String source) => RegExp(
  "name: '([A-Za-z_][A-Za-z0-9_]*)'",
).allMatches(source).map((m) => m.group(1)!).toSet();

/// The SDK types `sdk_errors.dart` declares it raises — the `implements`
/// targets of its error classes plus the declared return types of its factory
/// helpers.
Set<String> _sdkErrorTypes(String source) => {
  ...RegExp(
    r'class\s+\w+\s+extends\s+\w+\s+implements\s+(\w+)',
  ).allMatches(source).map((m) => m.group(1)!),
  ...RegExp(
    r'^(\w*(?:Error|Exception))\s+\w+\(',
    multiLine: true,
  ).allMatches(source).map((m) => m.group(1)!),
};
