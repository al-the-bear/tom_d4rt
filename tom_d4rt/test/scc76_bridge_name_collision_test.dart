// SCC76 — no stdlib bridge name may be defined twice.
//
// THE DEFECT SHAPE
//
// SCB26 was a duplicate bridge name: `StringSink` was registered by both the
// core and the io registrar. It survived for as long as it existed and only
// surfaced because SC9 happened to trip over the warning it logs. The cost was
// not the duplication itself — it was that the LAST registration wins, so
// `StringSink` silently lost three members it had in the other copy, and no
// test noticed.
//
// WHY IT STAYS INVISIBLE WITHOUT THIS FILE
//
// `Environment.defineBridgeLazy` handles a same-name collision by logging
// `Logger.warn('Redefining bridged class or colliding with existing
// definition: …')`, stashing the displaced bridge, and marking the name
// AMBIGUOUS only when `priorBridge.nativeType != nativeType`. Two definitions
// of the same native type therefore read as a benign re-export — which is a
// correct rule for two barrels exporting one class, and exactly wrong for two
// registrars that each define their own version of it. The collision is
// reported at log level, and the log is off in a normal test run.
//
// WHAT MAKES THE ASSERTION POSSIBLE
//
// `_recordShadowedBridge` runs on EVERY collision, unconditionally — before
// the nativeType comparison that decides ambiguity. So the displaced bridge is
// always retrievable, and `findAllBridgedClassesByName` (which returns primary
// plus shadowed across the scope chain) sees both copies whether or not the
// runtime considered the name ambiguous. A candidate count above one is
// therefore the exact question, with no production change needed to ask it.
//
// WHY THE REGISTRAR LIST IS NOT WRITTEN OUT HERE
//
// It would decay. F-SCC76-3 drives it from `ModuleLoader.stdlibModuleNames`,
// which SCC76 exposed for this purpose, so a `dart:` module added to the
// loader and not to this file fails rather than going unchecked. That is not
// hypothetical caution. The analyzer tree's `module_loader.dart` HAD a second
// copy of the registrar map in its type-resolution fallback, and the two had
// already drifted: the copy was missing `isolate`, so a bridge package
// depending on a `dart:isolate` type found nothing there while every other
// stdlib module was tried. SCC76 derived that loop from the one map. Two lists
// of the same thing is the shape this file guards, one level up.

// EACH ASSERTION HERE HAS BEEN SEEN TO FAIL. Three of the four assert an
// emptiness, and an emptiness passes on a measurement that never happened, so
// each was provoked deliberately:
//
//   | Injected fault                          | Fires             |
//   | --------------------------------------- | ----------------- |
//   | re-register one stdlib registrar        | F-SCC76-1, and -2 |
//   |                                         | asserts it        |
//   | drop `isolate` from _onDemandRegistrars | F-SCC76-3 and -4  |
//
// The second row is the interesting one: F-SCC76-3 named the missing module
// and F-SCC76-4 caught it independently through `SendPort`, so a registrar
// silently dropped from this file cannot hide behind either check alone.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
// `Environment` arrives through the stdlib registrar imports below; declaring
// it again would be redundant. `ModuleLoader` does not, and F-SCC76-3 needs it.
import 'package:tom_d4rt/src/stdlib/collection.dart';
import 'package:tom_d4rt/src/stdlib/convert.dart';
import 'package:tom_d4rt/src/stdlib/io.dart';
import 'package:tom_d4rt/src/stdlib/isolate.dart';
import 'package:tom_d4rt/src/stdlib/math.dart';
import 'package:tom_d4rt/src/stdlib/typed_data.dart';

/// The `dart:` modules this file registers, and how.
///
/// `typed_data` is deliberately absent from the on-demand half: `Stdlib`
/// registers it EAGERLY (GEN-106, so Flutter scripts reach `ByteData` without
/// an import) and it is also in the loader's on-demand map. Registering it
/// twice here would manufacture sixteen self-collisions and prove nothing
/// about the cross-registrar question this file asks. Production does not hit
/// that path — a script importing `dart:typed_data` resolves through the
/// loader's isolated per-stdlib environment — which was measured rather than
/// assumed, by running such a script with the logger at warning level and
/// finding no redefinition warning.
const _eagerlyRegistered = {'core', 'async', 'typed_data'};

final _onDemandRegistrars = <String, void Function(Environment)>{
  'math': MathStdlib.register,
  'convert': ConvertStdlib.register,
  'io': IoStdlib.register,
  'collection': CollectionStdlib.register,
  'isolate': IsolateStdlib.register,
};

/// One environment carrying every stdlib bridge at once.
///
/// This is the state a script reaches by importing several `dart:` libraries,
/// and it is the only state in which a cross-registrar collision is visible —
/// each registrar is internally consistent by construction.
Environment _fullyRegisteredEnvironment() {
  final env = Environment();
  Stdlib(env).register();
  for (final register in _onDemandRegistrars.values) {
    register(env);
  }
  return env;
}

/// `name -> candidate count`, for every name with more than one candidate.
Map<String, int> _collisions(Environment env) {
  final found = <String, int>{};
  for (final name in env.bridgedClassNames) {
    final count = env.findAllBridgedClassesByName(name).length;
    if (count != 1) found[name] = count;
  }
  return found;
}

/// SCD194 — THE ENUM NAMESPACE, AND THE DECISION IT CARRIED.
///
/// This guard could not be written for enums until SCD194, and the reason was
/// in the production code rather than here. `defineBridgeLazy` calls
/// `_recordShadowedBridge` on EVERY class collision, unconditionally, so the
/// displaced bridge survives and is countable. `defineBridgedEnum` warned and
/// overwrote: the displaced enum was gone, and the only trace was a log line
/// that is off in a normal run — which is precisely the condition that let
/// SCB26 live for its whole lifetime. The enum registry now keeps the same
/// bookkeeping, and F-SCD194-3 fails if that recording is taken away again.
///
/// THE DECISION, taken rather than defaulted: a colliding enum is RECORDED AND
/// REPORTED, not rejected. The class rule — same `nativeType` is a re-export,
/// a different one is Dart's ambiguous-import case — transfers in principle,
/// but the enum path has no qualifier machinery, so making a name ambiguous
/// would leave a script no way to say which one it meant. Recording first is
/// reversible and costs nothing; rejecting first would strand callers.
///
/// WHAT THE TWO EMPTINESS CASES ARE WORTH TODAY, stated because it is easy to
/// over-read them: the stdlib registers ZERO bridged enums (measured
/// 2026-09-06 and again 2026-09-15 — `FileMode` and its kind are
/// `BridgedClass`es), so F-SCD194-1 and -2 pass over an empty namespace.
/// F-SCD194-3 is what makes them more than decoration, and it asserts that
/// emptiness explicitly so the day it stops being true is the day somebody
/// re-reads all three.
///
/// `defineBridgedEnum` IS called from production code — `ast_module_loader`
/// and `d4rt_runner` merge bridged enums when loading a module — so a bridge
/// package whose enum name collides with another's is the live case, and it is
/// outside the stdlib these cases can reach.

/// The same, on the ENUM namespace.
///
/// SCD194 is what makes this writable. `defineBridgedEnum` used to warn and
/// overwrite, so a displaced enum left nothing behind to count — the guard
/// below could not have existed, and the only trace of a collision was a log
/// line that is off in a normal run. The enum registry now records the
/// displaced definition the way the class registry has since SCC76.
Map<String, int> _enumCollisions(Environment env) {
  final found = <String, int>{};
  for (final name in env.bridgedEnumNames) {
    final count = env.findAllBridgedEnumsByName(name).length;
    if (count != 1) found[name] = count;
  }
  return found;
}

/// Names registered as BOTH a bridged class and a bridged enum.
///
/// The third branch of `defineBridgedEnum`'s collision check, and the one
/// neither namespace can see alone: the class registry never learns that an
/// enum took its name, and the enum registry never learns the reverse. Only a
/// caller holding both can ask.
List<String> _crossNamespaceCollisions(Environment env) =>
    (env.bridgedEnumNames.toSet().intersection(
      env.bridgedClassNames.toSet(),
    )).toList()..sort();

void main() {
  test('F-SCC76-1: no stdlib bridge name is defined twice [2026-09-06]', () {
    final env = _fullyRegisteredEnvironment();
    final collisions = _collisions(env);

    // The message carries the native types, not just the names: two entries
    // for the SAME type is a registrar registered twice, and two entries for
    // DIFFERENT types is the SCB26 shape, where one definition's members
    // silently replace the other's. The remedies are not the same.
    final detail = collisions.keys.toList()..sort();
    expect(
      detail,
      isEmpty,
      reason:
          'These bridge names have more than one definition in scope at once. '
          'The last registration wins, so every member the loser declared and '
          'the winner does not has silently disappeared — that is SCB26, where '
          '`StringSink` lost three members for its whole lifetime.\n'
          '${detail.map((n) => '  $n -> '
              '${env.findAllBridgedClassesByName(n).map((b) => b.nativeType).toList()}').join('\n')}',
    );
  });

  test('F-SCC76-2: the guard detects a duplicate when there is one '
      '[2026-09-06]', () {
    // A guard nobody has watched fail is a guess about a guard, and this one
    // asserts an emptiness — the failure mode it must not have is passing
    // because it measured nothing. Re-registering one registrar is the
    // smallest real duplicate available.
    final env = _fullyRegisteredEnvironment();
    expect(_collisions(env), isEmpty, reason: 'precondition');

    TypedDataStdlib.register(env);
    final collisions = _collisions(env);

    expect(
      collisions.keys,
      contains('ByteData'),
      reason: 'a re-registered registrar must show as duplicate candidates',
    );
    expect(collisions['ByteData'], equals(2));
  });

  test('F-SCC76-3: this file registers every module the loader can '
      '[2026-09-06]', () {
    // The decay guard. A `dart:` module added to the loader but not here would
    // leave its bridges out of F-SCC76-1 entirely, and the suite would stay
    // green while checking less than it claims.
    final covered = {..._eagerlyRegistered, ..._onDemandRegistrars.keys};
    final missing =
        ModuleLoader.stdlibModuleNames
            .where((m) => !covered.contains(m))
            .toList()
          ..sort();
    expect(
      missing,
      isEmpty,
      reason:
          'ModuleLoader can register these `dart:` modules and this file does '
          'not, so their bridges are not being checked for collisions:\n'
          '  ${missing.join('\n  ')}\n'
          'Add each to _onDemandRegistrars (or to _eagerlyRegistered, if '
          'Stdlib.register now covers it).',
    );
  });

  test('F-SCC76-4: the environment really was populated [2026-09-06]', () {
    // F-SCC76-1 asserts an emptiness, so it passes on an environment where
    // nothing registered at all. This is the floor under it. The bound is far
    // below the real figure (205 names measured 2026-09-06) because its job is
    // to separate "measured" from "measured nothing", not to pin the count.
    final env = _fullyRegisteredEnvironment();
    expect(env.bridgedClassNames.length, greaterThan(150));
    // And a name from each registrar, so a single silently-skipped registrar
    // cannot hide behind the aggregate.
    for (final name in const [
      'Object', // core
      'Future', // async
      'ByteData', // typed_data
      'Random', // math
      'Utf8Codec', // convert
      'File', // io
      'Queue', // collection
      'SendPort', // isolate
    ]) {
      expect(
        env.bridgedClassNames,
        contains(name),
        reason: '$name should be registered; is its registrar wired up?',
      );
    }
  });

  test('F-SCD194-1: no stdlib enum name is defined twice [2026-09-15] '
      '(PASS)', () {
    final env = _fullyRegisteredEnvironment();
    final collisions = _enumCollisions(env);
    final detail = (collisions.keys.toList()..sort())
        .map((n) => '  $n -> ${collisions[n]} candidates')
        .join('\n');
    expect(
      collisions,
      isEmpty,
      reason:
          'These bridged ENUM names have more than one definition in scope at '
          'once:\n$detail\n'
          'The last registration wins and the others become unreachable — the '
          'class-namespace version of that is SCB26.',
    );
  });

  test('F-SCD194-2: no name is both a bridged class and a bridged enum '
      '[2026-09-15] (PASS)', () {
    // `defineBridgedEnum` warns about this case and then registers anyway, so
    // the name resolves to whichever registry the lookup consults first. That
    // is not a decision anybody made.
    final env = _fullyRegisteredEnvironment();
    final both = _crossNamespaceCollisions(env);
    expect(
      both,
      isEmpty,
      reason:
          'These names are registered in BOTH namespaces: ${both.join(', ')}.'
          '\nWhich one a bare name reaches depends on lookup order rather '
          'than on any rule. Register the enum as a BridgedClass (which is '
          'what every stdlib enum already does) or rename one of them.',
    );
  });

  test('F-SCD194-3: the enum guards detect a collision when there is one '
      '[2026-09-15] (PASS)', () {
    // The anti-vacuity case, and it carries more weight here than usual: the
    // stdlib registers ZERO bridged enums (measured 2026-09-06 and again
    // 2026-09-15 — stdlib enums like `FileMode` are `BridgedClass`es), so
    // F-SCD194-1 and -2 pass over an EMPTY namespace today. Without this case
    // they would be two assertions that have never touched anything, and would
    // keep passing if the recording SCD194 added were removed again.
    final env = _fullyRegisteredEnvironment();
    expect(
      env.bridgedEnumNames,
      isEmpty,
      reason:
          'The stdlib now registers bridged enums. That is not a problem, but '
          'this case was written when it registered none — re-read it, and '
          'note the real count in F-SCD194-1 so the emptiness above stops '
          'being vacuous.',
    );

    // Two DIFFERENT definitions under one name, built here because the stdlib
    // offers none.
    final first = BridgedEnumDefinition<_ProbeA>(
      name: 'ScdProbeEnum',
      values: _ProbeA.values,
      getters: {'label': (visitor, target) => 'a'},
    );
    final second = BridgedEnumDefinition<_ProbeB>(
      name: 'ScdProbeEnum',
      values: _ProbeB.values,
      getters: {'label': (visitor, target) => 'b'},
    );
    env.defineBridgedEnum(first.buildBridgedEnum());
    expect(_enumCollisions(env), isEmpty, reason: 'one definition, no clash');
    env.defineBridgedEnum(second.buildBridgedEnum());

    final collisions = _enumCollisions(env);
    expect(
      collisions.keys,
      contains('ScdProbeEnum'),
      reason:
          'the displaced enum must stay enumerable — this is exactly what '
          'SCD194 added to defineBridgedEnum',
    );
    expect(collisions['ScdProbeEnum'], equals(2));

    // And the cross-namespace half, on the same probe name.
    env.defineBridge(
      BridgedClass(nativeType: _ProbeCarrier, name: 'ScdProbeEnum'),
    );
    expect(_crossNamespaceCollisions(env), contains('ScdProbeEnum'));
  });
}

enum _ProbeA { one }

enum _ProbeB { two }

/// A native type for the cross-namespace probe. Its identity is all that
/// matters — the bridge is never instantiated.
class _ProbeCarrier {}
