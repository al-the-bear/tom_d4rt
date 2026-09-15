// `runtimeType` on a bridged value answers what real Dart answers.
//
// THE DEFECT, fixed by SCC78 and confirmed here: every value the interpreter
// wraps in a `BridgedInstance` reported `BridgedInstance<Object>`, because the
// `runtimeType` interception in `_handlePropertyAccess` read the type of the
// WRAPPER. It hit `File`, `HttpClient`, `ContentType` and the credentials
// family, and missed `Uri` (passed through raw) and `int` (handled natively) —
// which is why it read as "some types are fine".
//
// WHY THIS FILE EXISTS ON TOP OF SCC78's SEVEN CASES. Those assert
// RELATIONSHIPS (two unrelated types disagree, two instances of one type agree)
// and a few names as string literals. None of them compares the interpreter
// against Dart. That matters because of WHICH answer was chosen: SCD174 set out
// three candidates and took (a), `nativeObject.runtimeType` — "the one answer
// that cannot be wrong" — whose whole justification is that it matches the
// platform. An assertion that does not consult the platform cannot check that
// justification.
//
// SO EVERY EXPECTATION HERE IS COMPUTED, NOT WRITTEN. Each expression is
// evaluated twice: once by this test process as ordinary Dart, once by the
// interpreter, and the two `runtimeType.toString()` values must agree. A
// hard-coded `'_File'` would be a pin on today's SDK internals and would go red
// on an SDK that renames its private implementation — which is exactly the
// change this assertion should NOT care about.
//
// IT LEAKS PRIVATE SDK NAMES, and that is faithful rather than a wart. Real
// Dart answers `_File` for `File('x')`, and `File('x').runtimeType == File` is
// FALSE there too — measured, both sides, in F-SCD174-2. A script wanting the
// name it wrote has `is`, which is true in both.
//
// `hashCode`, the other half SCD174 asked to decide alongside, is already
// settled and guarded: `scc32_bridged_value_key_test.dart` is a REPO-WIDE GUARD
// that neither tree hashes a bridged value by wrapper identity. It is not
// duplicated here.

import 'dart:io';

import 'package:test/test.dart';

import 'interpreter_test.dart';

/// Expressions evaluated on both sides, with the native value to compare to.
///
/// The credentials family and a plain `File` are both present because SCD174
/// asked for them by name — the defect was found through credentials, and a fix
/// shaped around one bridge would be the obvious way to close it too narrowly.
final Map<String, Object> _subjects = {
  "File('x')": File('x'),
  "ContentType('a', 'b')": ContentType('a', 'b'),
  "HttpClientBasicCredentials('u', 'p')": HttpClientBasicCredentials('u', 'p'),
  "HttpClientDigestCredentials('u', 'p')": HttpClientDigestCredentials(
    'u',
    'p',
  ),
  "Uri.parse('http://a/')": Uri.parse('http://a/'),
  'StringBuffer()': StringBuffer(),
  'Duration(seconds: 1)': const Duration(seconds: 1),
  'Object()': Object(),
  '1': 1,
  "'a'": 'a',
};

void main() {
  group('SCD174: runtimeType answers what Dart answers', () {
    test('F-SCD174-1: the subject table covers wrapped and unwrapped values '
        '[2026-09-15] (PASS)', () {
      // Anti-vacuity, and specific about WHAT the table has to contain. The
      // defect missed `Uri` and `int` entirely, so a table of only wrapped
      // values would confirm the fix while proving nothing about the values
      // that were always right — and a table of only unwrapped ones would have
      // passed before the fix.
      expect(_subjects, hasLength(greaterThanOrEqualTo(8)));
      expect(
        _subjects.values.where((v) => v is File || v is ContentType),
        isNotEmpty,
        reason: 'no value that the interpreter wraps',
      );
      expect(
        _subjects.values.where((v) => v is int || v is String || v is Uri),
        isNotEmpty,
        reason: 'no value that the interpreter does not wrap',
      );
    });

    for (final entry in _subjects.entries) {
      test('F-SCD174-2-${entry.key}: matches Dart [2026-09-15] (PASS)', () {
        final native = entry.value.runtimeType.toString();
        expect(
          execute(
            "import 'dart:io';\n"
            'main() => (${entry.key}).runtimeType.toString();',
          ),
          native,
          reason:
              'the interpreter and Dart disagree about ${entry.key}. Before '
              'SCC78 every wrapped value answered BridgedInstance<Object> '
              'here.',
        );
      });
    }

    test('F-SCD174-3: `is` still names what the script wrote, where '
        'runtimeType names the implementation [2026-09-15] (PASS)', () {
      // The pair that makes the leaked private name acceptable. The
      // surprising half is checked against Dart directly — `runtimeType ==
      // File` really is FALSE there, because `File` is an interface and the
      // instance is `_File`. The `is` half is not asserted natively: the
      // analyzer resolves it statically and says so (`unnecessary_type_check`),
      // which is itself the confirmation.
      expect(File('x').runtimeType == File, isFalse);
      expect(
        execute(
          "import 'dart:io';\n"
          'main() => [File("x").runtimeType == File, File("x") is File];',
        ),
        [false, true],
      );
    });

    test('F-SCD174-4: two instances of one bridged type agree, and two '
        'bridged types differ [2026-09-15] (PASS)', () {
      // The relational half, kept because it is the one shape that a fix
      // returning some constant — a plausible wrong repair — would fail while
      // every string comparison above still passed.
      expect(
        execute(
          "import 'dart:io';\n"
          'main() => [\n'
          '  File("a").runtimeType == File("b").runtimeType,\n'
          '  File("a").runtimeType == ContentType("a", "b").runtimeType,\n'
          '];',
        ),
        [true, false],
      );
    });
  });
}
