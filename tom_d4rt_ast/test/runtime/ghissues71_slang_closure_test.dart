// ghissues71/AST — three defects that kept Slang's pure-Dart package closure
// (GitHub al-the-bear/tom_d4rt#21) from loading, run from bundles.
//
// The fixtures `fixtures/ghissues71_<name>.bundle.json` are the programs of
// tom_d4rt's `test/ghissues71_slang_closure_test.dart`, bundled by
// tom_ast_generator (`tool/write_ghissues71_fixtures.dart` there) and run
// here through `toBytes` / `fromBytes`, the reporter's path. Every
// expectation is what native Dart 3.13 answers.
//
// 1. Deferred imports (`SImportDirective.isDeferred`): `loadLibrary()`
//    completes; a member read before it throws `Deferred library <prefix> was
//    not loaded.`
// 2. A library's `_` members are not part of the interface another library
//    implements.
// 3. `dart:collection`'s `MapView` is bridged and can be extended.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

AstBundle _bundle(String name) {
  final json =
      jsonDecode(
            File(
              'test/runtime/fixtures/ghissues71_$name.bundle.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return AstBundle.fromBytes(AstBundle.fromJson(json).toBytes());
}

Object? _run(String bundle, [String name = 'main']) =>
    D4rtRunner().executeBundle(_bundle(bundle), name: name);

void main() {
  group('ghissues71/AST: deferred imports', () {
    test('GH71A-1: the bundle carries the deferred import, loadLibrary '
        'completes and the members resolve [2026-11-18]', () async {
      final bundle = _bundle('deferred');
      final import = bundle.entryPoint.directives
          .whereType<SImportDirective>()
          .firstWhere((d) => d.prefix?.name == 'z');
      expect(import.isDeferred, isTrue);
      expect(await (_run('deferred', 'loaded') as Future), ['zf', 7, 'c']);
    });

    test('GH71A-2: a member read before loadLibrary throws as in Dart '
        '[2026-11-18]', () {
      for (final entry in ['callBefore', 'valueBefore', 'classBefore']) {
        expect(
          () => _run('deferred', entry),
          throwsA(
            isA<DeferredLibraryNotLoadedD4rtException>().having(
              (e) => e.message,
              'message',
              'Deferred library z was not loaded.',
            ),
          ),
          reason: entry,
        );
      }
    });

    test('GH71A-3: the script catches it; a module importing deferred '
        'loads it itself [2026-11-18]', () async {
      expect(_run('deferred', 'caught'), isTrue);
      expect(await (_run('deferred', 'fromLibrary') as Future), 'zf');
    });
  });

  group('ghissues71/AST: another library\'s private interface members', () {
    test('GH71A-4: not part of the interface another library implements '
        '[2026-11-18]', () {
      expect(_run('private'), 2);
    });

    test('GH71A-5: required in their own library [2026-11-18]', () {
      expect(
        () => _run('private_same_library'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("interface method '_hidden'"),
          ),
        ),
      );
    });
  });

  group('ghissues71/AST: MapView', () {
    test('GH71A-6: a class extending MapView reads and writes the wrapped '
        'map [2026-11-18]', () {
      expect(_run('mapview', 'readWrite'), [
        1,
        2,
        ['a', 'b'],
        true,
        '{a: 1, b: 2}',
      ]);
    });

    test('GH71A-7: MapView and UnmodifiableMapView by themselves, and is '
        '[2026-11-18]', () {
      expect(_run('mapview', 'views'), [
        {'k': 2, 'j': 3},
        true,
        true,
        true,
        true,
        true,
      ]);
    });
  });
}
