// ghissues73/AST — a write into a collection the script created with
// written type arguments is checked against them, as Dart's run-time check
// does: `(<String>[] as dynamic).add(1)` throws
// `type 'int' is not a subtype of type 'String' of 'value'`. Every
// expectation is native Dart 3.13's, except where noted: four writes Dart
// refuses for the ARGUMENT's static type (an untyped `[1]`, a closure typed
// `() => String`, a `Map<String, String>` literal, a `List<MapEntry<..>>`)
// are refused here for the element they would store, with that element in
// the message.
//
// Run from a bundle: the fixture `fixtures/ghissues73_writes.bundle.json` is
// tom_d4rt's test program, bundled by tom_ast_generator
// (`tool/write_ghissues73_fixtures.dart` there).

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

Object? _run(String name) {
  final json =
      jsonDecode(
            File(
              'test/runtime/fixtures/ghissues73_writes.bundle.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final bundle = AstBundle.fromBytes(AstBundle.fromJson(json).toBytes());
  return D4rtRunner().executeBundle(bundle, name: name);
}

void main() {
  group('ghissues73/AST: writes into a written collection', () {
    test('GH73A-1: a wrongly typed element is refused as in Dart, with its '
        'message [2026-11-18]', () {
      expect(_run('rejected'), [
        "TypeError: type 'int' is not a subtype of type 'String' of 'value'",
        "TypeError: type 'int' is not a subtype of type 'String' of 'element'",
        "TypeError: type 'int' is not a subtype of type 'String' of 'value'",
        "TypeError: type 'Null' is not a subtype of type 'String' of 'value'",
        "TypeError: type 'List<Object>' is not a subtype of type 'Iterable<String>' of 'iterable'",
        "TypeError: type 'String' is not a subtype of type 'int' of 'key'",
        "TypeError: type 'String' is not a subtype of type 'int' of 'value'",
        "TypeError: type 'int' is not a subtype of type 'String' of 'key'",
        "TypeError: type 'String' is not a subtype of type 'P' of 'value'",
        "TypeError: type 'int' is not a subtype of type 'String' of 'value'",
      ]);
    });

    test('GH73A-2: an argument whose static type Dart refuses is refused for '
        'the element it would store [2026-11-18]', () {
      final results = (_run('rejectedByValue') as List).cast<String>();
      expect(results, hasLength(4));
      expect(results, everyElement(startsWith('TypeError: ')));
    });

    test('GH73A-3: correct writes, untyped collections and an int into a '
        'double list (widened) are accepted [2026-11-18]', () {
      expect(_run('accepted'), [
        '[z, b, c]',
        '[null]',
        1,
        '{k: 2, j: 2}',
        '[1]',
        '{1: x}',
        '[1.0]',
      ]);
    });
  });
}
