// No bridged member is declared in two of a bridge's maps at once.
//
// The analyzer-free twin of
// `tom_d4rt/test/stdlib/scd196_member_map_disjointness_test.dart`, which this
// tree did not have. SCD196 found nineteen members declared twice — eleven
// `buffer` entries across the typed-data lists, `hashCode` on five bridges,
// `toString` on three, `reversed` on one — every one an accident of the same
// kind: a member added to whichever map the author was looking at, beside a
// correct entry in the other. It fixed them in BOTH trees and guarded only
// one.
//
// WHY THE MIRROR GUARD IS NOT ENOUGH, which is the reason this file exists
// rather than a note saying the trees agree. A mirror guard reports that two
// files DIFFER; it never reports which of them is right. If a duplicate
// registration were ever reintroduced on this side, or removed on the other,
// the mirror would say "drift" and neither tree would say "wrong". And this is
// the tree a Flutter app ships, so a bridge declaring one member twice HERE is
// the one that reaches a user.
//
// WHY IT MATTERS THOUGH NOTHING LOOKS BROKEN. The interpreter's property-read
// path calls the getter adapter first, so a duplicate method is inert on the
// paths a script normally takes. `BridgedInstance.get` is METHODS-first, so a
// caller reaching the member through that primitive gets the bound callable
// instead of the value — SCC73's `Runes.iterator` failure, with a getter
// masking it everywhere else.
//
// THE REGISTRY IS THE ORACLE, NOT THE SOURCE. Auditing by grepping `getters:`
// and `methods:` blocks out of `lib/**/stdlib` reports false positives that
// read as entirely real: `io/file.dart` declares `read` on `FileMode` (a
// static getter) and on `RandomAccessFile` (a method); `io/http.dart` declares
// `value` on four different classes. A class is the unit the mistake lives in,
// so a class is what has to be asked.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib.dart';

/// Pairs of maps that may never share a name.
///
/// Setters are absent from the getter rows deliberately: Dart lets one name be
/// both a getter and a setter, and most bridges declare exactly that.
const Map<String, (String, String)> _mustBeDisjoint = {
  // One of the two is wrong: the member is either called or read, never both.
  'methods/getters': ('methods', 'getters'),
  // `x.foo(...)` and `x.foo = v` cannot both be right for one name.
  'methods/setters': ('methods', 'setters'),
  'staticMethods/staticGetters': ('staticMethods', 'staticGetters'),
  'staticMethods/staticSetters': ('staticMethods', 'staticSetters'),
};

Set<String> _keysOf(BridgedClass bridge, String map) => switch (map) {
  'methods' => bridge.methods.keys.toSet(),
  'getters' => bridge.getters.keys.toSet(),
  'setters' => bridge.setters.keys.toSet(),
  'staticMethods' => bridge.staticMethods.keys.toSet(),
  'staticGetters' => bridge.staticGetters.keys.toSet(),
  'staticSetters' => bridge.staticSetters.keys.toSet(),
  _ => throw ArgumentError('unknown map $map'),
};

/// The floor the control asserts. The stdlib registers ~197 bridges; a number
/// far below that means a registrar did not run, not that the corpus is clean.
const int _minBridges = 150;

void main() {
  late List<String> findings;
  late int scanned;

  setUpAll(() {
    final env = Environment();
    Stdlib(env).register();
    CollectionStdlib.register(env);
    ConvertStdlib.register(env);
    IoStdlib.register(env);

    findings = <String>[];
    scanned = 0;
    // `findAllBridgedClassesByName`, not the singular lookup: the bare-name
    // view keeps only the LAST-registered bridge when two share a name, so
    // asking for one would silently skip the other. Measured 2026-09-21: 197
    // names, 197 bridges, no collisions — so this is a no-op today and is
    // written this way because a guard that quietly narrows is worse than one
    // that fails.
    for (final name in (env.bridgedClassNames..sort())) {
      for (final bridge in env.findAllBridgedClassesByName(name)) {
        scanned++;
        for (final pair in _mustBeDisjoint.values) {
          final shared = (_keysOf(
            bridge,
            pair.$1,
          ).intersection(_keysOf(bridge, pair.$2)).toList()..sort());
          for (final member in shared) {
            findings.add('  $name.$member in both ${pair.$1} and ${pair.$2}');
          }
        }
      }
    }
  });

  test('F-SCE70-AST-2 (control): the registry was populated [2026-09-21]', () {
    // The case below is an emptiness over this scan, and an environment where
    // no registrar ran satisfies it perfectly while asking nothing.
    expect(
      scanned,
      greaterThanOrEqualTo(_minBridges),
      reason:
          'Only $scanned bridges were scanned. That is not a finding about '
          'duplicate declarations — the registrars did not run.',
    );
  });

  test('F-SCE70-AST-1: no bridge declares one member in two maps '
      '[2026-09-21]', () {
    expect(
      findings,
      isEmpty,
      reason:
          'These bridges declare one member twice:\n${findings.join('\n')}\n\n'
          'One of the two entries is wrong, and the SDK decides which: '
          '`hashCode` and `buffer` are getters, `toString` is a method. Delete '
          'the other, and pin the removal — a deletion of script-visible '
          'surface cannot be protected by an assertion that passes.',
    );
  });
}
