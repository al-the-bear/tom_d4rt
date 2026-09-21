// SCE74: when the SDK throws, a script must be able to catch the SDK's type.
//
// SCD31 named three shapes of invented error contract. Its stage-1 grep and the
// standing `nullable_returns_do_not_throw_test.dart` detect SHAPE (1) only —
// a bridge that throws where the SDK RETURNS, which changes the value contract
// and so shows up in any probe that reads the value. This file is the detector
// for SHAPE (2): the bridge throws where the SDK also throws, but with a type
// nothing can catch. The two behave identically until a script tries to
// recover, which is why every reasonable "does it fail on empty?" test passed
// while SCD30's `Queue.removeFirst` was wrong.
//
// SCD30 fixed that one by hand and left the open question: "there is no
// evidence the family stops at Queue." It did not. Run against the matrix
// below on 2026-09-21, `elementAt(0)` on an empty `Queue`, `ListQueue` and
// `DoubleLinkedQueue` answered `RuntimeD4rtException: Invalid arguments for
// bridged method 'ListQueue.elementAt'` where Dart answers `IndexError`.
//
// THE CAUSE WAS NOT IN `stdlib/` AT ALL, which is why a grep of the bridges
// found nothing. `BridgedMethodCallable` caught `ArgumentError` to improve the
// message for adapter arity problems — and `RangeError extends ArgumentError`,
// `IndexError implements RangeError`, so that one clause silently swallowed
// every SDK range failure from every bridged method. SCE74 narrowed it.
//
// WHY THE EXPECTATION IS COMPUTED, NOT WRITTEN DOWN. Each case runs the same
// operation twice: once on a native Dart collection to learn what the SDK
// throws, once inside an interpreted script that must catch exactly that type.
// A hand-written table of expected types would be a second thing to maintain
// and would go stale against the SDK; here the SDK is the oracle, so a member
// whose behaviour changes in a future Dart is re-measured rather than re-read.
//
// AND WHY THE ASSERTION IS A SCRIPT-LEVEL CATCH. A host-side
// `throwsA(isA<StateError>())` is not sufficient — the interpreter may wrap on
// the way out — so the assertion is made inside the script, in a `try` /
// `on <Type>` block whose recovery path returns a value the test reads. This
// is SCD30's F-SCD30-1-* pattern, generalised.

import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// What kind of receiver a member can be asked of. Explicit rather than
/// inferred: probing applicability by catching `NoSuchMethodError` also
/// swallows a genuine one, and probing it by casting turns an inapplicable
/// pair into a fake `TypeError` finding.
enum Kind { list, set, queue, map }

class Receiver {
  const Receiver(this.name, this.script, this.make, this.kind);
  final String name;
  final String script;
  final Object Function() make;
  final Kind kind;
}

final _receivers = <Receiver>[
  Receiver('List', '<int>[]', () => <int>[], Kind.list),
  Receiver('Set', '<int>{}', () => <int>{}, Kind.set),
  Receiver('Queue', 'Queue()', () => Queue<int>(), Kind.queue),
  Receiver('ListQueue', 'ListQueue()', () => ListQueue<int>(), Kind.queue),
  Receiver(
    'DoubleLinkedQueue',
    'DoubleLinkedQueue()',
    () => DoubleLinkedQueue<int>(),
    Kind.queue,
  ),
  Receiver('HashSet', 'HashSet()', () => HashSet<int>(), Kind.set),
  Receiver(
    'LinkedHashSet',
    'LinkedHashSet()',
    // The named constructor is the bridge under test; a literal would build a
    // plain LinkedHashSet and measure a different registration.
    // ignore: prefer_collection_literals
    () => LinkedHashSet<int>(),
    Kind.set,
  ),
  Receiver(
    'SplayTreeSet',
    'SplayTreeSet()',
    () => SplayTreeSet<int>(),
    Kind.set,
  ),
  Receiver('Map', '<String,int>{}', () => <String, int>{}, Kind.map),
  Receiver('HashMap', 'HashMap()', () => HashMap<String, int>(), Kind.map),
  Receiver(
    'LinkedHashMap',
    'LinkedHashMap()',
    // ignore: prefer_collection_literals — as above.
    () => LinkedHashMap<String, int>(),
    Kind.map,
  ),
  Receiver(
    'SplayTreeMap',
    'SplayTreeMap()',
    () => SplayTreeMap<String, int>(),
    Kind.map,
  ),
];

class Member {
  const Member(this.name, this.script, this.invoke, this.on);
  final String name;
  final String script;
  final Object? Function(Object) invoke;
  final Set<Kind> on;
}

/// The receiver is empty in every case, so these are the state-dependent
/// members whose SDK contract is an error rather than a value.
final _members = <Member>[
  Member('first', 'c.first', (c) => (c as Iterable).first, {
    Kind.list,
    Kind.set,
    Kind.queue,
  }),
  Member('last', 'c.last', (c) => (c as Iterable).last, {
    Kind.list,
    Kind.set,
    Kind.queue,
  }),
  Member('single', 'c.single', (c) => (c as Iterable).single, {
    Kind.list,
    Kind.set,
    Kind.queue,
  }),
  // The case SCE74 found. Kept first among the index members because it is the
  // one that was wrong on three types at once.
  Member(
    'elementAt(0)',
    'c.elementAt(0)',
    (c) => (c as Iterable).elementAt(0),
    {Kind.list, Kind.set, Kind.queue},
  ),
  Member(
    'reduce',
    'c.reduce((a,b)=>a)',
    // Typed deliberately: `(c as Iterable<int>)` makes `a` and `b` `int`, so
    // the call fails on the EMPTY STATE. An untyped receiver makes the closure
    // itself the failure and reports `TypeError` for every row — a probe
    // artefact that reads exactly like a finding.
    (c) => (c as Iterable<int>).reduce((a, b) => a),
    {Kind.list, Kind.set, Kind.queue},
  ),
  Member('removeFirst', 'c.removeFirst()', (c) => (c as Queue).removeFirst(), {
    Kind.queue,
  }),
  Member('removeLast', 'c.removeLast()', (c) => (c as Queue).removeLast(), {
    Kind.queue,
  }),
  Member('removeAt(0)', 'c.removeAt(0)', (c) => (c as List).removeAt(0), {
    Kind.list,
  }),
  Member('[0]', 'c[0]', (c) => (c as List)[0], {Kind.list}),
  Member('keys.first', 'c.keys.first', (c) => (c as Map).keys.first, {
    Kind.map,
  }),
  Member('values.first', 'c.values.first', (c) => (c as Map).values.first, {
    Kind.map,
  }),
  Member('entries.first', 'c.entries.first', (c) => (c as Map).entries.first, {
    Kind.map,
  }),
];

/// The SDK's answer, as a name a script can write in an `on` clause.
String? _sdkThrows(Member m, Receiver r) {
  try {
    m.invoke(r.make());
    return null; // returns a value — shape (1), not this file's subject
  } on StateError {
    return 'StateError';
  } on IndexError {
    return 'IndexError';
  } on RangeError {
    return 'RangeError';
  } on UnsupportedError {
    return 'UnsupportedError';
  } on ArgumentError {
    return 'ArgumentError';
  }
}

String _script(Receiver r, Member m, String sdkType) =>
    '''
import 'dart:collection';
main() {
  var c = ${r.script};
  try { ${m.script}; return "no throw"; }
  on $sdkType catch (_) { return "caught"; }
  catch (e) { return "escaped"; }
}''';

void main() {
  group('SCE74: an SDK error keeps its type across the bridge', () {
    final cases = <(Receiver, Member, String)>[];
    for (final r in _receivers) {
      for (final m in _members) {
        if (!m.on.contains(r.kind)) continue;
        final sdk = _sdkThrows(m, r);
        if (sdk != null) cases.add((r, m, sdk));
      }
    }

    test('F-SCE74-1: the matrix is populated and reaches every receiver '
        '[2026-09-21] (PASS)', () {
      // Without this the file could silently degrade to nothing — an
      // applicability set that stopped matching, or an SDK change that made
      // every member return, would leave zero cases and a green run.
      expect(cases.length, greaterThanOrEqualTo(40), reason: 'case count');
      expect(
        cases.map((c) => c.$1.name).toSet(),
        hasLength(_receivers.length),
        reason: 'every receiver contributes at least one throwing member',
      );
    });

    for (final (r, m, sdk) in cases) {
      test('F-SCE74-2[${r.name}.${m.name}]: an empty receiver raises $sdk '
          'and a script catches it [2026-09-21] (PASS)', () {
        expect(
          D4rt().execute(source: _script(r, m, sdk)),
          'caught',
          reason:
              '`${r.script}` then `${m.script}`: Dart raises $sdk, so a script '
              'written `on $sdk` must recover. "escaped" means the bridge '
              'threw something else — shape (2): the value contract matches, '
              'the catch does not.',
        );
      });
    }
  });
}
