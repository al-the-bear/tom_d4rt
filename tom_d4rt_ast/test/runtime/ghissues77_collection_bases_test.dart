// REPO-WIDE GUARD (tom_d4rt_ast) — this tree's copy of ghissues77's program is tom_d4rt's.
// ghissues77/AST - dart:collection's bases and Iterable as superclasses and
// mixins of script classes (GitHub #21, Slang's package closure), and the
// fixes the closure needed after them, in the analyzer-free tree.
//
// The mirror of `tom_d4rt/test/ghissues77_collection_bases_test.dart`.
// `fixtures/ghissues77_program.dart` (a copy of tom_d4rt's) is imported here
// for native Dart's answers; its bundle `fixtures/ghissues77_program.bundle.json`
// (tom_ast_generator's `tool/write_ghissues77_fixtures.dart`) is run by the
// interpreter, through toBytes / fromBytes. Each test compares the two:
// ListBase, SetBase, MapBase, UnmodifiableMapBase and the Iterable bridge
// with their typedef aliases (IterableBase, IterableMixin, ListMixin,
// SetMixin, MapMixin) as superclasses and mixins; an interface a bridged base
// provides; statics not reachable through an instance; a Set field from
// `{}`; an extension type parameter in a local function; async, async* and
// sync* extension methods; an extension on Comparator<T>.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

import '../sibling_trees.dart';
import 'fixtures/ghissues77_program.dart' as native;

final AstBundle _bundle = AstBundle.fromBytes(
  AstBundle.fromJson(
    jsonDecode(
          File(
            'test/runtime/fixtures/ghissues77_program.bundle.json',
          ).readAsStringSync(),
        )
        as Map<String, dynamic>,
  ).toBytes(),
);

Object? _run(String name) => D4rtRunner().executeBundle(_bundle, name: name);

List<String> _strings(Object? value) => [for (final e in value as List) '$e'];

void main() {
  requirePackage(
    'tom_d4rt_ast',
    subject:
        'tom_d4rt/test/fixtures/ghissues77_program.dart, the program this '
        'bundle is a copy of',
  );

  test('GH77A-0: the bundled program is the tom_d4rt fixture [2026-11-18]', () {
    expect(
      File('test/runtime/fixtures/ghissues77_program.dart').readAsStringSync(),
      File(
        '../tom_d4rt/test/fixtures/ghissues77_program.dart',
      ).readAsStringSync(),
      reason:
          'copy tom_d4rt\'s program here and run '
          'tom_ast_generator/tool/write_ghissues77_fixtures.dart',
    );
  });

  group('ghissues77/AST: collection bases, side by side with native Dart', () {
    test('GH77A-1: Iterable, IterableBase, IterableMixin [2026-11-18]', () {
      expect(_strings(_run('iterables')), native.iterables());
    });

    test('GH77A-2: ListBase, ListMixin [2026-11-18]', () {
      expect(_strings(_run('lists')), native.lists());
    });

    test('GH77A-3: SetBase, SetMixin [2026-11-18]', () {
      expect(_strings(_run('sets')), native.sets());
    });

    test('GH77A-4: MapBase, MapMixin, UnmodifiableMapBase [2026-11-18]', () {
      expect(_strings(_run('maps')), native.maps());
    });
  });

  group('ghissues77/AST: what Slang\'s closure needed besides the bases', () {
    test('GH77A-5: an interface a bridged base provides, statics through an '
        'instance, a Set field, an extension type parameter in a local '
        'function [2026-11-18]', () {
      expect(_strings(_run('closure')), native.closure());
    });

    test('GH77A-6: async, async* and sync* extension methods run past their '
        'first suspension [2026-11-18]', () async {
      final result = await (_run('asyncClosure') as Future<Object?>);
      expect(_strings(result), await native.asyncClosure());
    });

    test('GH77A-7: an extension on Comparator<T> [2026-11-18]', () {
      expect(_strings(_run('comparators')), native.comparators());
    });
  });
}
