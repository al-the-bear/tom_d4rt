// ghissues77 - dart:collection's bases and Iterable as superclasses and
// mixins of script classes (GitHub #21, Slang's package closure), and the
// interpreter fixes the closure needed after them.
//
// `test/fixtures/ghissues77_program.dart` is valid Dart: imported here for
// native Dart's answers, and its text run by the interpreter. Each group
// compares the two. The AST twin runs a bundle of the same program
// (tom_d4rt_ast/test/runtime/ghissues77_collection_bases_test.dart).
//
// What it covers:
// * `extends Iterable / IterableBase / ListBase / SetBase / MapBase /
//   UnmodifiableMapBase` and `with IterableMixin / ListMixin / MapMixin`: the
//   script gives the members the SDK leaves abstract, every other member is
//   the SDK's, run on a receiver proxy (D4.markProxyIsReceiver); a member the
//   script overrides (`C.length`) is the script's; `is`, `toString`,
//   `List.of(x)` and `jsonEncode(x)` see a List, Set, Map or Iterable;
// * an interface whose members a bridged base and `Object` provide
//   (`class Z extends IterableBase<int> implements Described`);
// * a static member is not reachable through an instance (`instance.hello`
//   is the extension's), an empty `{}` initializing a `Set` field is a set,
//   a local function typed by an extension's type parameter takes any value,
//   async / async* / sync* extension methods run past their first suspension,
//   and an extension on `Comparator<T>` applies to a comparator.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

import 'fixtures/ghissues77_program.dart' as native;

final _source = File(
  'test/fixtures/ghissues77_program.dart',
).readAsStringSync();

Object? _run(String name) => D4rt().execute(
  library: 'package:p/main.dart',
  sources: {'package:p/main.dart': _source},
  name: name,
);

List<String> _strings(Object? value) => [for (final e in value as List) '$e'];

void main() {
  group('ghissues77: collection bases, side by side with native Dart', () {
    test('GH77-1: Iterable, IterableBase, IterableMixin [2026-11-18]', () {
      expect(_strings(_run('iterables')), native.iterables());
    });

    test('GH77-2: ListBase, ListMixin [2026-11-18]', () {
      expect(_strings(_run('lists')), native.lists());
    });

    test('GH77-3: SetBase, SetMixin [2026-11-18]', () {
      expect(_strings(_run('sets')), native.sets());
    });

    test('GH77-4: MapBase, MapMixin, UnmodifiableMapBase [2026-11-18]', () {
      expect(_strings(_run('maps')), native.maps());
    });
  });

  group('ghissues77: what Slang\'s closure needed besides the bases', () {
    test('GH77-5: an interface a bridged base provides, statics through an '
        'instance, a Set field, an extension type parameter in a local '
        'function [2026-11-18]', () {
      expect(_strings(_run('closure')), native.closure());
    });

    test('GH77-6: async, async* and sync* extension methods run past their '
        'first suspension [2026-11-18]', () async {
      final result = await (_run('asyncClosure') as Future<Object?>);
      expect(_strings(result), await native.asyncClosure());
    });

    test('GH77-7: an extension on Comparator<T> [2026-11-18]', () {
      expect(_strings(_run('comparators')), native.comparators());
    });
  });
}
