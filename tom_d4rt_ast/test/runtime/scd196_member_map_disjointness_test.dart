// No bridged member is declared in two of a bridge's maps at once.
//
// SCC77 found `StringSinkCore.hashCode` in both `methods` and `getters` and
// fixed that one. Sweeping for the shape found eighteen more — eleven `buffer`
// entries across the typed-data lists, `hashCode` on four more bridges,
// `toString` on three, `reversed` on one. Every one of them was an accident of
// the same kind: a member added to whichever map the author was looking at,
// beside a correct entry in the other.
//
// WHY IT MATTERS THOUGH NOTHING IS BROKEN. The interpreter's property-read path
// calls `findInstanceGetterAdapter` FIRST, for ordinary reads and inside the
// cascade branch, so the getter answers and the duplicate method is inert.
// `BridgedInstance.get` — the primitive on the class itself — is METHODS-first:
//
//     final methodAdapter = bridgedClass.findInstanceMethodAdapter(name);
//     if (methodAdapter != null) return BridgedMethodCallable(...);
//
// so a caller reaching a member through that gets the bound callable instead of
// the value. That is SCC73's `Runes.iterator` failure exactly — the value looks
// fine until something calls it — differing only in that a getter also exists
// to mask it on the other paths.
//
// SCE232 LATER MADE `BridgedInstance.get` GETTERS-FIRST, and this guard is why
// that was safe. Nothing in the interpreter calls it, and no getter reads its
// visitor, so the change was free WHILE the intersection below is empty: no
// method name could answer differently. The paragraph above describes the
// primitive as it was. This guard is still what keeps the two read paths in
// agreement.
//
// WHY THIS GUARD AND NOT A RE-ORDERING. SCD196 offered making
// `BridgedInstance.get` getters-first as the deeper fix, and it is the wrong
// trade here. It is a behaviour change on a public primitive, so it needs its
// own measurement and its own blast-radius argument; and it removes the
// SYMPTOM while leaving a bridge free to declare one member twice, which is
// what future readers would go on doing. An empty intersection makes the
// ordering unobservable — with no name in both maps, methods-first and
// getters-first cannot differ — so the cheaper fix is also the more complete
// one. If the ordering is changed later it should be for its own reasons, not
// for these.
//
// WHAT IT DOES NOT ASSERT, said plainly because the omission looks like an
// oversight. A GETTER and a SETTER under one name is ordinary Dart and is not
// reported. Only method/getter, method/setter and their static counterparts
// are — the pairs where one declaration must be wrong.
//
// THE SDK-ORACLE VERSION IS A DIFFERENT CHECK, not a duplicate.
// `scd189_member_kind_parity_test.dart` asks whether each registration matches
// the kind the SDK DECLARES; this asks whether a bridge contradicts ITSELF, and
// needs no oracle at all. The five survivors this file was written for —
// `hashCode` on `Match`, `Pattern`, `Sink`, `toString` on
// `IsolateSpawnException` and `RemoteError` — were invisible to SCD189 because
// those SDK classes declare no supertype, so its walk never reached `Object`
// where `hashCode` and `toString` live. That gap is fixed in the same change;
// the two guards now overlap on these five and diverge everywhere else.
//
// WIDENING SCD189's WALK IS PART OF THIS CHANGE, and it found two more that
// neither guard could see before. `Object` is every class's supertype and is
// almost never written down, so a walk following only written `extends` /
// `implements` clauses stops at `abstract interface class Match {` and reports
// every inherited member as unspeakable — a pass. With `Object` in the walk,
// F-SCD189-1 reported `IOSink.toString` registered as a getter and
// `MapEntry.hashCode` registered as a method.
//
// `MapEntry.hashCode` WAS A LIVE DEFECT, not a latent one, and it is the case
// this whole family exists for. Measured before the fix, on the reference tree:
//
//     e.hashCode      ->  not an int   (the bound callable)
//     e.hashCode()    ->  an int       (uncompilable as Dart)
//
// Nothing masked it — no getter existed to answer first — so
// `map.entries.first.hashCode` silently was not a hash. F-SCD196-3 pins the
// repaired reads here too (SCE239). This package has no parser, so it runs a
// hand-built BUNDLE through `D4rtRunner`: the same programs as the reference
// twin's scripts, and the interpreter this tree's working copy actually is.
//
// EACH CASE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                       | Fires |
//   | ---------------------------------------------------- | ----- |
//   | `hashCode` put back in `Sink`'s methods map           | 1     |
//   | the registrars not run, leaving an empty environment  | 2     |
//   | `MapEntry.hashCode` moved back to the methods map     | none* |
//   | ... and the GEN-075 `hashCode` read removed            | 3     |
//
// * Since SCE239 both trees answer `hashCode` and `runtimeType` on a bridged
//   value natively before consulting any member map (GEN-075, in
//   `visitPropertyAccess` and `visitPrefixedIdentifier`). So a misregistered
//   `hashCode` is invisible to a program, which is what F-SCD196-3 asserts, and
//   it is caught instead where the registration is the subject: F-SCD189-1,
//   member-kind parity (measured: it fires). Until SCE239 the reference's
//   `visitPrefixedIdentifier` lacked that read, and `e.hashCode` exposed the
//   defect there while the twin masked it, one line of mirror divergence.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/typed_data.dart';

/// 208 bridges registered on 2026-09-15. The floor is well below that because
/// its job is to separate "scanned the registry" from "scanned nothing".
const int _minBridges = 150;

Environment _fullyRegisteredEnvironment() {
  final env = Environment();
  Stdlib(env).register();
  AsyncStdlib.register(env);
  CollectionStdlib.register(env);
  ConvertStdlib.register(env);
  IoStdlib.register(env);
  IsolateStdlib.register(env);
  MathStdlib.register(env);
  TypedDataStdlib.register(env);
  return env;
}

/// The pairs of maps that must not share a name, and why each is a
/// contradiction rather than a style choice.
///
/// A getter/setter pair is deliberately absent: `x.foo` and `x.foo = v` are one
/// member in Dart and two entries here, which is correct.
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

void main() {
  late Environment env;
  late List<String> findings;
  late int scanned;

  setUpAll(() {
    env = _fullyRegisteredEnvironment();
    findings = <String>[];
    scanned = 0;
    for (final name in (env.bridgedClassNames..sort())) {
      final bridge = env.findBridgedClassByName(name);
      if (bridge == null) continue;
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
  });

  test('F-SCD196-2 (control): the registry was populated [2026-09-15] '
      '(PASS)', () {
    // F-SCD196-1 is an emptiness over this scan, and an environment where no
    // registrar ran satisfies it perfectly.
    expect(
      scanned,
      greaterThanOrEqualTo(_minBridges),
      reason:
          'Only $scanned bridges were scanned. That is not a finding about '
          'duplicate declarations — the registrars did not run.',
    );
  });

  test('F-SCD196-1: no bridge declares one member in two maps [2026-09-15] '
      '(PASS)', () {
    expect(
      findings,
      isEmpty,
      reason:
          'These bridges declare one member twice:\n${findings.join('\n')}\n\n'
          'One of the two entries is wrong, and which one is decided by the '
          'SDK: `hashCode` and `buffer` are getters, `toString` is a method. '
          'Delete the other.\n\n'
          'Nothing may be visibly broken — the interpreter reads getters first, '
          'so a duplicate method is inert on the paths a script takes. '
          '`BridgedInstance.get` reads getters first too since SCE232, but '
          'only because no name is in both maps — this case is what keeps it '
          'so.',
    );
  });

  test('F-SCD196-3: MapEntry.hashCode reads as a value [2026-09-29] '
      '(PASS)', () {
    // SCE239: the behavioural half, which this tree lacked. `hashCode` was in
    // the METHODS map with no getter beside it, so reading it returned the
    // bound callable. The registration check above says which map it is in;
    // this says what a program sees.
    expect(
      _run(_isInt(_get(_mapEntry(), 'hashCode'))),
      isTrue,
      reason: "MapEntry('a', 1).hashCode is int",
    );
    // `{'a': 1}.entries.first.hashCode is int` — the ordinary way to reach
    // a MapEntry.
    final map = SSetOrMapLiteral(
      offset: 0,
      length: 0,
      isMap: true,
      elements: [
        SMapLiteralEntry(offset: 0, length: 0, key: _str('a'), value: _int(1)),
      ],
    );
    expect(
      _run(_isInt(_get(_get(_get(map, 'entries'), 'first'), 'hashCode'))),
      isTrue,
      reason: 'the ordinary way to reach a MapEntry',
    );
    // `toString` stays a method, which is what the SDK declares.
    expect(
      _run(
        SMethodInvocation(
          offset: 0,
          length: 0,
          target: _mapEntry(),
          operator: '.',
          methodName: _id('toString'),
          argumentList: SArgumentList(offset: 0, length: 0),
        ),
      ),
      'MapEntry(a: 1)',
    );
  });
}

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: 0, value: v);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 0, value: v);

SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

/// `MapEntry('a', 1)`
SExpression _mapEntry() => SInstanceCreationExpression(
  offset: 0,
  length: 0,
  constructorName: SConstructorName(
    offset: 0,
    length: 0,
    type: _type('MapEntry'),
  ),
  argumentList: SArgumentList(
    offset: 0,
    length: 0,
    arguments: [_str('a'), _int(1)],
  ),
);

/// `x is int`
SExpression _isInt(SExpression x) =>
    SIsExpression(offset: 0, length: 0, expression: x, type: _type('int'));

/// Runs a bundle whose `main` is `=> [expression]`, and returns the result.
Object? _run(SExpression expression) {
  final unit = SCompilationUnit(
    offset: 0,
    length: 0,
    declarations: [
      SFunctionDeclaration(
        offset: 0,
        length: 0,
        name: _id('main'),
        functionExpression: SFunctionExpression(
          offset: 0,
          length: 0,
          parameters: SFormalParameterList(offset: 0, length: 0),
          body: SExpressionFunctionBody(
            offset: 0,
            length: 0,
            expression: expression,
          ),
        ),
      ),
    ],
  );
  return D4rtRunner().executeBundle(
    AstBundle(entryPointUri: 'main.dart', modules: {'main.dart': unit}),
  );
}
