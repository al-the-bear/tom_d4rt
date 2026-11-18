// ghissues79 (GitHub #23) - a constructor tear-off of a class reached through
// an import prefix: `generated.Protocol.new`, as Serverpod 4.1's generated
// `ProtocolDeserialization.cached` writes it, failed with
// `Undefined static member 'new' on class 'Protocol'`. `generated.Protocol`
// resolves to the class and `.new` reached the class arm of
// visitPropertyAccess, which had no constructor tear-off; visitPrefixedIdentifier
// (`Protocol.new`) had one. Both now share one helper per class kind.
//
// The issue's two files, extended (test/fixtures/ghissues79/), are valid
// Dart: imported here for native Dart's answers and run by the interpreter.
// The AST twin runs bundles of the same files
// (tom_d4rt_ast/test/runtime/ghissues79_prefixed_constructor_tearoff_test.dart).

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'fixtures/ghissues79/main.dart' as native;

String _read(String file) =>
    File('test/fixtures/ghissues79/$file').readAsStringSync();

Object? _run(String name) => D4rt().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart': _read('main.dart'),
    'package:p/protocol.dart': _read('protocol.dart'),
  },
  name: name,
);

void main() {
  group('ghissues79: prefix.Class.new', () {
    test('GH79-1: GitHub #23\'s repro answers [7, 7, 11, 11] [2026-11-18]', () {
      expect(native.main(), [7, 7, 11, 11]);
      expect(_run('main'), native.main());
    });

    test(
      'GH79-2: a generative, an implicit, a named and a generic '
      'constructor, and a bridged class, through the prefix [2026-11-18]',
      () {
        expect([for (final e in _run('extras') as List) '$e'], native.extras());
      },
    );
  });
}
