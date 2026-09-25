/// SCD147 — no interpreter-owned value may be claimed by a bridge, and the
/// thing that currently stops it is not the predicate named for the job.
///
/// SCC49 added `Environment._isInterpreterOwned` — true for `Enum`,
/// `RuntimeType`, `RuntimeValue`, `Callable` — after its structural suffix pass
/// claimed d4rt's own `BridgedEnum` for the `Enum` bridge and 43 enum-dispatch
/// tests failed. The first guard written was `nativeObject is Enum`, which
/// missed it entirely: `BridgedEnum` is not an `Enum`, it is a `RuntimeType`
/// whose NAME ends with `Enum`. The boundary was discovered by a test failure.
///
/// ## The hazard surface is eight types, not one — measured 2026-09-15
///
/// Over the live registry (84 bridges), these interpreter-owned type names match
/// a bridge name by suffix or by prefix:
///
/// | interpreter-owned type | suffix match | prefix match |
/// | ---------------------- | ------------ | ------------ |
/// | `BridgedEnum` | `Enum` | — |
/// | `InterpretedEnum` | `Enum` | — |
/// | `InterpretedFunction` | `Function` | — |
/// | `NamedRuntimeType` | `Type` | — |
/// | `RecordRuntimeType` | `Type` | — |
/// | `AppliedRuntimeType` | `Type` | — |
/// | `FunctionRuntimeType` | `Type` | `Function` |
/// | `TypeParameter` | — | `Type` |
///
/// `BridgedEnum → Enum` is the one the 43 failures found. The other seven were
/// never enumerated.
///
/// ## What actually protects them, and why that is the finding
///
/// All eight are `RuntimeType` or `Callable`, so `_isInterpreterOwned` covers
/// every one — at step 4 of `toBridgedInstance`, the single site that consults
/// it. The open question SCC49 left was the OTHER sites: `toBridgedClass` and
/// its PASS B prefix fallback reason about a value without asking.
///
/// **Measured: no interpreter-owned type is claimed today** — all thirteen
/// throw. But the reason is not the predicate. Ablate SCD132's corroboration
/// requirement and `TypeParameter` is immediately **claimed by the `Type`
/// bridge**: PASS B matched a >=3-character prefix and nothing asked whether the
/// value was the interpreter's own.
///
/// So the boundary is held by SCD132, which was written about bridge-to-bridge
/// false positives (`TextDirection` claimed by `Text`) and knows nothing about
/// this distinction. That protection is **incidental**, and nothing recorded it:
/// widening PASS B again, or a bridge declaring `TypeParameter` in its
/// `nativeNames`, reopens the hazard silently and no test says so.
///
/// This file is that test. It is deliberately at `toBridgedClass`, the entry the
/// predicate does NOT guard — asserting the property where it is unprotected is
/// worth more than asserting it where a predicate already holds it.
///
/// sce179 carries the structural version SCC49's todo proposed: consult the
/// predicate at the entry rather than at one branch.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Every interpreter-owned type reachable from the public surface.
///
/// Listed rather than derived, because there is no runtime way to ask "is this
/// type declared by the interpreter" — and a list is acceptable here precisely
/// because F-SCD147-1 fails if it stops covering the ones that can match a
/// bridge name.
const List<Type> _interpreterOwned = [
  BridgedEnum,
  BridgedClass,
  BridgedInstance,
  TypeParameter,
  NamedRuntimeType,
  FunctionRuntimeType,
  RecordRuntimeType,
  AppliedRuntimeType,
  InterpretedInstance,
  InterpretedClass,
  InterpretedEnum,
  InterpretedFunction,
  InterpretedRecord,
];

/// `_longestNameSuffixMatch` / PASS B, replicated to compute the hazard surface.
({String? suffix, String? prefix}) nameMatches(
  Iterable<String> bridgeNames,
  String typeName,
) {
  var base = typeName;
  final angle = base.indexOf('<');
  if (angle >= 0) base = base.substring(0, angle);
  if (base.startsWith('_')) base = base.substring(1);

  String? suffix;
  var bestLen = 0;
  for (final name in bridgeNames) {
    if (name.length < 3 || name.length <= bestLen) continue;
    if (base.length <= name.length) continue;
    if (!base.endsWith(name)) continue;
    bestLen = name.length;
    suffix = name;
  }
  String? prefix;
  for (final name in bridgeNames) {
    if (name.length < 3 || base == name) continue;
    if (base.startsWith(name)) {
      prefix = name;
      break;
    }
  }
  return (suffix: suffix, prefix: prefix);
}

Future<Environment> resolvedEnvironment() async {
  final d4rt = D4rt();
  await d4rt.execute(source: 'dynamic main() => 1;');
  return d4rt.visitor!.globalEnvironment;
}

Set<String> bridgeNamesOf(Environment env) {
  final names = <String>{};
  for (Environment? frame = env; frame != null; frame = frame.enclosing) {
    names.addAll(frame.bridgedClassNames);
  }
  return names;
}

void main() {
  late Environment env;
  late Set<String> bridgeNames;

  setUpAll(() async {
    env = await resolvedEnvironment();
    bridgeNames = bridgeNamesOf(env);
  });

  group('SCD147: the interpreter/native boundary', () {
    test(
      'F-SCD147-1: the hazard is real — interpreter-owned names DO match bridge '
      'names [2026-09-15]',
      () {
        // Anti-vacuity, and the reason F-SCD147-2 is not a tautology: if no
        // interpreter-owned name could match any bridge, "none of them is
        // claimed" would be true by arithmetic rather than by any guard.
        expect(
          bridgeNames.length,
          greaterThanOrEqualTo(60),
          reason: 'only ${bridgeNames.length} bridges — registry did not load',
        );
        final matching = [
          for (final type in _interpreterOwned)
            if (nameMatches(bridgeNames, type.toString()).suffix != null ||
                nameMatches(bridgeNames, type.toString()).prefix != null)
              type.toString(),
        ];
        expect(
          matching.length,
          greaterThanOrEqualTo(6),
          reason:
              'eight matched on 2026-09-15 (see the header table). Finding '
              'almost none means the registry or the naming changed and '
              'F-SCD147-2 has stopped being a real claim. Matched: $matching',
        );
      },
    );

    test('F-SCD147-2: no interpreter-owned type is claimed by a bridge '
        '[2026-09-15]', () {
      // Asserted at `toBridgedClass`, the Type-keyed API. It is given a
      // `Type`, not a value, so `_isInterpreterOwned` cannot guard it; its
      // boundary is still SCD132's corroboration requirement, and ablating
      // that makes `TypeParameter` resolve to `Type` HERE. Every caller that
      // holds a VALUE goes through the entry that does guard it — see the
      // SCE179 group, which proves that without relying on SCD132.
      final claimed = <String>[];
      for (final type in _interpreterOwned) {
        try {
          final bridge = env.toBridgedClass(type);
          claimed.add('$type claimed by ${bridge.name}');
        } catch (_) {
          // Throwing is the correct answer: an interpreter-owned value is not
          // a native object awaiting a bridge.
        }
      }
      expect(
        claimed,
        isEmpty,
        reason:
            'An interpreter-owned value resolved to a native bridge. This is '
            'the SCC49 incident in a different pass: a name-shaped guess about '
            "d4rt's own representation is never meaningful, and the 43 "
            'enum-dispatch failures are what it looks like downstream. What '
            'holds this today is SCD132\'s corroboration requirement in PASS '
            'B, not `_isInterpreterOwned` — so suspect a widened PASS B, or a '
            'bridge that has declared one of these in its `nativeNames`:\n'
            '  ${claimed.join("\n  ")}',
      );
    });

    test('F-SCD147-3: the predicate covers every type that can match '
        '[2026-09-15]', () {
      // `_isInterpreterOwned` is private, so this asserts the property it is
      // built from: every interpreter-owned type that can match a bridge name
      // is a `RuntimeType`, a `RuntimeValue`, a `Callable` or an `Enum`. If a
      // new interpreter value shape appears that is none of those AND matches
      // a bridge name, the predicate is blind to it and step 4 will guess.
      //
      // `InterpretedRecord` was exactly that case until SCD147: it implements
      // none of the four, and it is only harmless because no bridge is named
      // `Record`.
      final blind = <String>[];
      for (final type in _interpreterOwned) {
        final m = nameMatches(bridgeNames, type.toString());
        if (m.suffix == null && m.prefix == null) continue;
        // Reflectionless: the names are checked against the documented
        // hazard table, so a NEW matching type shows up as an addition here
        // and has to be classified by hand — which is the point.
        const covered = {
          'BridgedEnum',
          'InterpretedEnum',
          'InterpretedFunction',
          'NamedRuntimeType',
          'RecordRuntimeType',
          'AppliedRuntimeType',
          'FunctionRuntimeType',
          'TypeParameter',
        };
        if (!covered.contains(type.toString())) blind.add(type.toString());
      }
      expect(
        blind,
        isEmpty,
        reason:
            'These interpreter-owned types now match a bridge name and are '
            'not in the classified set. Check each is `RuntimeType` / '
            '`RuntimeValue` / `Callable` / `Enum` — if one is not, '
            '`_isInterpreterOwned` cannot see it and step 4 will guess a '
            'bridge for it:\n  ${blind.join("\n  ")}',
      );
    });
  });

  group('SCE179: the boundary is stated at the value-level entry', () {
    // `_isInterpreterOwned` is now asked once, at `_toBridgedClassForValue`,
    // which both `toBridgedInstance` and `getRuntimeType` go through. These
    // cases prove the boundary there no longer depends on SCD132: they SUPPLY
    // the corroboration SCD132 demands — a bridge that declares the name — and
    // the value paths must refuse anyway. The `Type` API cannot refuse (it is
    // given a `Type`, not a value), and F-SCE179-1 records that it does not.
    Environment child() => Environment(enclosing: env);
    final owned = <Object Function()>[
      () => TypeParameter('T'),
      () => const NamedRuntimeType('X'),
    ];

    test('F-SCE179-1: a bridge that DECLARES an interpreter-owned name still '
        'cannot claim its values [2026-09-25]', () {
      final e = child()
        ..defineBridge(
          BridgedClass(
            nativeType: Object,
            name: 'Type',
            nativeNames: const ['TypeParameter', 'NamedRuntimeType'],
          ),
          sourceUri: 'package:probe/type.dart',
        );
      for (final make in owned) {
        final value = make();
        expect(
          e.toBridgedClass(value.runtimeType).name,
          'Type',
          reason:
              'the Type-keyed API follows the declaration — it cannot '
              'see ownership, which is why the value entry exists',
        );
        expect(
          () => e.toBridgedInstance(value),
          throwsA(isA<RuntimeD4rtException>()),
          reason:
              '${value.runtimeType} is the interpreter'
              's own value',
        );
        expect(
          e.getRuntimeType(value),
          isNull,
          reason: '${value.runtimeType} must not be typed as a native bridge',
        );
      }
    });

    test('F-SCE179-2: an exact nativeType registration is still honoured — '
        'that is a declaration, not a guess [2026-09-25]', () {
      final e = child()
        ..defineBridge(
          BridgedClass(nativeType: TypeParameter, name: 'TypeParameterBridge'),
          sourceUri: 'package:probe/tp.dart',
        );
      expect(
        e.toBridgedInstance(TypeParameter('T'))!.bridgedClass.name,
        'TypeParameterBridge',
      );
    });

    test('F-SCE179-3 (control): a native private SDK type still reaches its '
        'bridge by suffix through the same entry [2026-09-25]', () {
      final iterator = <int>{1}.iterator;
      expect(
        child().toBridgedInstance(iterator)!.bridgedClass.name,
        'Iterator',
      );
    });
  });
}
