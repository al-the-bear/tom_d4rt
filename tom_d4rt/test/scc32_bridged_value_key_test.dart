import 'dart:io';

import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCC32 — a bridged value hashed by wrapper identity instead of by value.
///
/// Every value produced by a bridged *constructor* is a `BridgedInstance`
/// wrapper, and the wrapper overrode only `toString()`. So it compared and
/// hashed by identity, and two separately constructed wrappers around equal
/// natives were different keys: `{Duration(seconds: 1): 1}[Duration(
/// seconds: 1)]` was null, `{Symbol('a')}.contains(Symbol('a'))` was false.
///
/// **The shape of the bug is what made it dangerous.** `a == b` on two such
/// values answered `true`, so a script got the right answer from `==` and the
/// wrong answer from every hash-based collection, with no error either way.
///
/// **`==` was never actually routed to the native.** The todo assumed it was
/// and that only `hashCode` was missing. Measurement says otherwise: the `true`
/// came from [visitBinaryExpression], which unwraps *both operands* to their
/// natives before comparing — the wrapper's own `==` was not consulted. Two
/// things follow. First, the fix needs `==` as much as `hashCode`. Second, the
/// symptom set is wider than hashing: `[Duration(seconds: 1)].contains(
/// Duration(seconds: 1))` was false and `indexOf` was `-1`, and neither of
/// those hashes at all (F-SCC32-9).
///
/// **Why wrapper equality alone was not enough.** D4rt reaches a map by two
/// different routes. `m[k]` passes `k` through untouched, so the lookup key
/// arrives as a *wrapper*; `m.containsKey(k)` is a bridge method call whose
/// arguments are unwrapped on the way in, so the same key arrives as a bare
/// *native*. Dart's hash lookup asks `lookupKey == storedKey` — the lookup key
/// is the receiver — so a wrapper looking up a stored native succeeds through
/// the new `operator ==`, while a bare native looking up a stored wrapper is
/// rejected by the native's own `==`, which no code here can override. Fixing
/// only the wrapper therefore made `[]` work while `containsKey` stayed broken,
/// which is *worse* than the status quo: the two spellings disagreed instead of
/// being uniformly wrong. F-SCC32-6 is the case that caught this.
///
/// So the fix has two halves, and both are needed:
///
/// 1. `BridgedInstance` delegates `==` and `hashCode` to its native, including
///    across the wrapper/native boundary.
/// 2. Hash keys are normalized to the native *at storage* — map-literal keys
///    and Set-literal elements — so no stored key is ever a wrapper and the
///    unfixable direction never arises.
///
/// The second half generalizes RC-7, which already did exactly this for
/// `BridgedEnumValue` and for exactly this reason; it replaces that enum-only
/// special case rather than sitting beside it.
///
/// **Cross-boundary equality is required, not speculative.** D4rt is
/// inconsistent about wrapping: a constructor yields a wrapper, but every
/// bridged *method* return yields a bare native. So `DateTime(2021).difference(
/// x)` and `Duration(seconds: 1)` are the same value in two representations and
/// routinely meet in one collection (F-SCC32-10/11/12). That inconsistency is
/// itself a defect and is tracked separately as SCD98.
///
/// **What deliberately did not change.** Interpreted classes are untouched —
/// a plain one still keys by identity, and one that defines `==`/`hashCode`
/// still collapses (F-SCC32-13/14). Lists keep their element representation,
/// because a list is not hash-keyed and the wrapper's own `==` now answers
/// correctly on its own.

/// Packages whose sources are mirrors of one another, relative to the repo root.
const _mirroredPackages = ['tom_d4rt', 'tom_d4rt_ast', 'tom_d4rt_exec'];

/// Where `BridgedInstance` lives in each tree.
const _wrapperSites = [
  'tom_d4rt/lib/src/bridge/bridged_types.dart',
  'tom_d4rt_ast/lib/src/runtime/bridge/bridged_types.dart',
];

/// Where the storage-side key normalization lives in each tree.
const _normalizationSites = [
  'tom_d4rt/lib/src/interpreter_visitor.dart',
  'tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart',
];

Directory? _repoRoot() {
  var dir = Directory.current.absolute;
  for (var i = 0; i < 6; i++) {
    final hasAll = _mirroredPackages.every(
      (p) => Directory('${dir.path}/$p').existsSync(),
    );
    if (hasAll) return dir;
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return null;
}

void main() {
  group('SCC32: a bridged value is a value key', () {
    test('F-SCC32-1: a Duration reaches its map entry [2026-09-05]', () {
      final result = execute('''
        main() {
          final m = {Duration(seconds: 1): 1};
          return m[Duration(seconds: 1)];
        }
      ''');
      expect(result, 1);
    });

    test('F-SCC32-2: a DateTime reaches its map entry [2026-09-05]', () {
      final result = execute('''
        main() {
          final m = {DateTime(2020, 1, 1): 1};
          return m[DateTime(2020, 1, 1)];
        }
      ''');
      expect(result, 1);
    });

    test('F-SCC32-3: a Symbol reaches its map entry [2026-09-05]', () {
      final result = execute('''
        main() {
          final m = {Symbol('alpha'): 1};
          return m[Symbol('alpha')];
        }
      ''');
      expect(result, 1);
    });

    test('F-SCC32-4: hashCode agrees with == [2026-09-05]', () {
      // The pair that used to disagree. `==` answered true (via the operand
      // unwrapping in visitBinaryExpression) while the hashes differed, which
      // is precisely the combination that puts a value in the wrong bucket
      // without raising anything.
      final result = execute('''
        main() {
          final a = Duration(seconds: 1);
          final b = Duration(seconds: 1);
          return '\${a == b}|\${a.hashCode == b.hashCode}';
        }
      ''');
      expect(result, 'true|true');
    });

    test('F-SCC32-5: a set literal finds its bridged member [2026-09-05]', () {
      final result = execute('''
        main() {
          final s = {Symbol('a')};
          return s.contains(Symbol('a'));
        }
      ''');
      expect(result, isTrue);
    });

    test('F-SCC32-6: containsKey and [] give the same answer [2026-09-05]', () {
      // The case that rejected the wrapper-only fix. These two spellings reach
      // the map by different routes — `[]` passes the key through as a wrapper,
      // `containsKey` is a bridge call that unwraps it — so they are the direct
      // test of whether normalizing at storage was necessary. Both key
      // spellings are exercised because the divergence was asymmetric.
      final result = execute('''
        main() {
          final d = {Duration(seconds: 1): 1};
          final s = {Symbol('a'): 1};
          return '\${d.containsKey(Duration(seconds: 1))}|'
                 '\${d[Duration(seconds: 1)] != null}|'
                 '\${s.containsKey(Symbol('a'))}|'
                 '\${s[Symbol('a')] != null}';
        }
      ''');
      expect(result, 'true|true|true|true');
    });

    test(
      'F-SCC32-7: equal bridged values collapse in a literal [2026-09-05]',
      () {
        final result = execute('''
        main() {
          final m = {Duration(seconds: 1): 'a', Duration(seconds: 1): 'b'};
          final s = {Symbol('x'), Symbol('x')};
          return '\${m.length}|\${m[Duration(seconds: 1)]}|\${s.length}';
        }
      ''');
        expect(result, '1|b|1');
      },
    );

    test('F-SCC32-8: remove finds the entry [2026-09-05]', () {
      final result = execute('''
        main() {
          final m = {Duration(seconds: 1): 1};
          m.remove(Duration(seconds: 1));
          return m.length;
        }
      ''');
      expect(result, 0);
    });

    test('F-SCC32-9: list membership does not hash and was broken too '
        '[2026-09-05]', () {
      // `contains` and `indexOf` walk the list calling `==`. They were wrong
      // before the fix, which is the evidence that `hashCode` alone could never
      // have been the whole answer. List elements are deliberately *not*
      // normalized — the wrapper's own `==` now answers correctly.
      final result = execute('''
        main() {
          final l = [Duration(seconds: 1)];
          return '\${l.contains(Duration(seconds: 1))}|'
                 '\${l.indexOf(Duration(seconds: 1))}';
        }
      ''');
      expect(result, 'true|0');
    });

    test('F-SCC32-10: a raw native looks up a key stored as a wrapper '
        '[2026-09-05]', () {
      // The direction that wrapper equality cannot reach: a bare native's `==`
      // rejects a wrapper and cannot be overridden. It resolves only because
      // the stored key was normalized. `difference` is a bridged method, so its
      // result is a bare `Duration` rather than a wrapper.
      final result = execute('''
        main() {
          final m = {Duration(seconds: 1): 'w'};
          final raw = DateTime(2020, 1, 1, 0, 0, 1)
              .difference(DateTime(2020, 1, 1));
          return m[raw];
        }
      ''');
      expect(result, 'w');
    });

    test('F-SCC32-11: a wrapper looks up a key stored as a raw native '
        '[2026-09-05]', () {
      final result = execute('''
        main() {
          final raw = DateTime(2020, 1, 1, 0, 0, 1)
              .difference(DateTime(2020, 1, 1));
          final m = {raw: 'r'};
          return m[Duration(seconds: 1)];
        }
      ''');
      expect(result, 'r');
    });

    test('F-SCC32-12: a set holds one member across representations '
        '[2026-09-05]', () {
      final result = execute('''
        main() {
          final raw = DateTime(2020, 1, 1, 0, 0, 1)
              .difference(DateTime(2020, 1, 1));
          final s = {raw, Duration(seconds: 1)};
          return s.length;
        }
      ''');
      expect(result, 1);
    });

    test('F-SCC32-13: a plain interpreted class still keys by identity '
        '[2026-09-05]', () {
      // The change is scoped to bridged wrappers. An interpreted class with no
      // `==` keeps Dart's own semantics, so two instances remain distinct keys
      // — loosening that would be a silent behaviour change of its own.
      final result = execute('''
        class P { int x; P(this.x); }
        main() {
          final a = P(1);
          final m = {a: 1, P(1): 2};
          return '\${m[P(1)]}|\${m.length}';
        }
      ''');
      expect(result, 'null|2');
    });

    test('F-SCC32-14: an interpreted class with == still collapses '
        '[2026-09-05]', () {
      final result = execute('''
        class Q {
          int x;
          Q(this.x);
          bool operator ==(Object o) => o is Q && o.x == x;
          int get hashCode => x.hashCode;
        }
        main() {
          final m = {Q(1): 'a', Q(1): 'b'};
          return '\${m[Q(1)]}|\${m.length}';
        }
      ''');
      expect(result, 'b|1');
    });

    test('F-SCC32-15: a normalized key is still usable as a value '
        '[2026-09-05]', () {
      // Normalization changes the *representation* a key is stored in, so the
      // thing to check is that reading it back still behaves. A raw native is
      // a first-class d4rt value — member access on it works the same way.
      final result = execute('''
        main() {
          final m = {Duration(seconds: 1): 'x'};
          final s = {Duration(seconds: 2)};
          return '\${m.keys.first.inSeconds}|\${s.first.inSeconds}';
        }
      ''');
      expect(result, '1|2');
    });

    test('F-SCC32-16: a map value keeps its representation [2026-09-05]', () {
      // Only keys are normalized. A value has no bucketing role, so touching
      // it would be change without cause.
      final result = execute('''
        main() {
          final m = {'k': Duration(seconds: 3)};
          return m['k'].inSeconds;
        }
      ''');
      expect(result, 3);
    });

    test('F-SCC32-17: a null-aware set element normalizes too [2026-09-05]', () {
      // `?element` reaches a different branch of the same function, so it needs
      // its own case or the normalization is present on one spelling only.
      final result = execute('''
        main() {
          final d = Duration(seconds: 1);
          final s = {?d};
          return s.contains(Duration(seconds: 1));
        }
      ''');
      expect(result, isTrue);
    });

    test('F-SCC32-18: plain keys are unaffected [2026-09-05]', () {
      // The control. Nothing in the common path should have moved.
      final result = execute('''
        main() {
          final m = {'a': 1, 2: 'b', true: 'c'};
          return '\${m['a']}|\${m[2]}|\${m[true]}|\${m.length}';
        }
      ''');
      expect(result, '1|b|c|3');
    });

    test('F-SCC32-19: an enum key still works [2026-09-05]', () {
      // RC-7's case, which this change absorbed rather than left alongside. If
      // the generalization dropped the enum branch, this is what would say so.
      final result = execute('''
        import 'dart:typed_data';
        main() {
          final m = {Endian.big: 1};
          return m[Endian.big];
        }
      ''');
      expect(result, 1);
    });
  });

  group('SCC32: the fix is present in both mirrored trees', () {
    final repoRoot = _repoRoot();

    test('F-SCC32-20: both halves of the fix exist in both trees '
        '[2026-09-05]', () {
      // The behavioural cases above can only measure `tom_d4rt` — the
      // analyzer-free twin has no parser, so a script-level case cannot be
      // written there, and `tom_d4rt_exec` resolves `tom_d4rt_ast` from pub.dev
      // (DGUC6) so its suite reports the *published* interpreter. A source scan
      // from one process is the only check that fails when a fix lands in one
      // half and not the other. Same device as F-SCC31-17.
      if (repoRoot == null) {
        markTestSkipped('mirrored checkout not present');
        return;
      }
      final missing = <String>[];
      for (final relative in _wrapperSites) {
        final file = File('${repoRoot.path}/$relative');
        expect(file.existsSync(), isTrue, reason: '$relative should exist');
        final source = file.readAsStringSync();
        if (!source.contains('int get hashCode => nativeObject.hashCode')) {
          missing.add('$relative (hashCode delegation)');
        }
      }
      for (final relative in _normalizationSites) {
        final file = File('${repoRoot.path}/$relative');
        expect(file.existsSync(), isTrue, reason: '$relative should exist');
        if (!file.readAsStringSync().contains('_unwrapHashKey')) {
          missing.add('$relative (storage-side normalization)');
        }
      }
      expect(
        missing,
        isEmpty,
        reason:
            'SCC32 needs both halves in both trees. Missing: ${missing.join(', ')}',
      );
    });

    test('F-SCC32-21: no enum-only key normalization survives [2026-09-05]', () {
      // RC-7's line was `if (key is BridgedEnumValue) key = key.nativeValue;`
      // at the map-literal site. Leaving it in place beside `_unwrapHashKey`
      // would be a second, narrower rule covering a subset of the same cases —
      // harmless today and a trap the next time one of them is edited.
      if (repoRoot == null) {
        markTestSkipped('mirrored checkout not present');
        return;
      }
      final offenders = <String>[];
      for (final relative in _normalizationSites) {
        final source = File('${repoRoot.path}/$relative').readAsStringSync();
        for (final line in source.split('\n')) {
          final trimmed = line.trim();
          if (trimmed.startsWith('//')) continue;
          // The helper's own `return key.nativeValue` is the rule, not a
          // duplicate of it. The site being guarded against *assigns*, which is
          // how RC-7 was written and how a reintroduction would be written.
          if (trimmed.contains('key is BridgedEnumValue') &&
              trimmed.contains('key = key.nativeValue')) {
            offenders.add('$relative: $trimmed');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'the enum-only rule should be subsumed by _unwrapHashKey, not kept '
            'beside it: ${offenders.join(' | ')}',
      );
    });
  });
}
