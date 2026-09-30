// SCF44: reading a member of a value does not require importing the library
// that declares the value's type.
//
// `import 'dart:io'; main() => stdout.encoding.name;` failed with "Undefined
// property or method 'name' on Utf8Codec. No bridge claims this type" until
// the script added `import 'dart:convert';`. In Dart, imports govern which
// NAMES a script can write, not which members a value it already holds
// exposes. A stdlib module's type→bridge mapping reached the lookup only when
// the module was imported; a latent registry of the libraries a script did not
// import now answers a value's bridge, by precise matches only, while their
// names stay out of scope.
//
// This is a name-resolution change, so the test is script-level (the scd5a
// pattern). The analyzer-free twin is
// `tom_d4rt_ast/test/runtime/scf44_member_access_without_import_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// PUBLISH-BLOCKED (DGUC6): exec resolves `tom_d4rt_ast` from pub.dev, and
/// the release carrying scf44 is 0.203.0. Remove the skip — which makes the
/// file the reference verbatim again — when exec's floor passes it.
const _publishBlocked =
    'PUBLISH-BLOCKED: needs tom_d4rt_ast 0.203.0 (scf44, published by scf42)';

Object? _run(String source, {bool io = false}) {
  final d4rt = D4rt();
  if (io) d4rt.grant(FilesystemPermission.any);
  return d4rt.execute(source: source);
}

class _Token {
  _Token(this.value);
  final int value;
}

void main() {
  group(
    'SCF44: member access needs no import of the declaring library',
    skip: _publishBlocked,
    () {
      test('F-SCF44-1: stdout.encoding.name with only dart:io imported '
          '[2026-09-30] (PASS)', () {
        expect(
          _run("import 'dart:io'; main() => stdout.encoding.name;", io: true),
          'utf-8',
        );
      });

      test('F-SCF44-2: a dart:convert value reached without importing it '
          '[2026-09-30] (PASS)', () {
        // `systemEncoding` is dart:io; its members come from dart:convert's
        // `Encoding` bridge.
        expect(
          _run(
            "import 'dart:io'; main() => systemEncoding.encode('A').first;",
            io: true,
          ),
          65,
        );
      });

      test('F-SCF44-3: a host bridge the script never imported '
          '[2026-09-30] (PASS)', () {
        final d4rt = D4rt()
          ..registerBridgedClass(
            BridgedClass(
              nativeType: _Token,
              name: 'Token',
              getters: {'value': (visitor, target) => (target as _Token).value},
            ),
            'package:test/token.dart',
          )
          ..registerBridgedClass(
            BridgedClass(
              nativeType: _Maker,
              name: 'Maker',
              staticMethods: {
                'make': (visitor, positional, named, typeArgs) => _Token(7),
              },
            ),
            'package:test/maker.dart',
          );
        expect(
          d4rt.execute(
            source:
                "import 'package:test/maker.dart'; main() => Maker.make().value;",
          ),
          7,
        );
      });

      test('F-SCF44-4: control — the NAME stays unresolvable without its '
          'import [2026-09-30] (PASS)', () {
        expect(
          () => _run("import 'dart:io'; main() => Utf8Codec().name;", io: true),
          throwsA(predicate((e) => '$e'.contains('Utf8Codec'))),
        );
        expect(
          () => _run("main() => Token;"),
          throwsA(predicate((e) => '$e'.contains('Token'))),
        );
      });
    },
  );
}

class _Maker {}
