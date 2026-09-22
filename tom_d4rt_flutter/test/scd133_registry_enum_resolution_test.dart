// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter) — asserts a property of the
// INTERPRETER (`Environment.getRuntimeType`) across this package's entire
// bridge registry. It lives here because this is where a registry that large
// exists; the code it protects lives in `tom_d4rt`.
//
/// SCD133 — every bridged enum in the live Flutter registry must resolve to
/// ITSELF.
///
/// ## The property
///
/// `Environment.getRuntimeType(v)`, for a raw native `Enum`, must return that
/// enum's own `BridgedEnum`. SCC46 added the branch that does so. Before it,
/// such a value fell through to `Environment.toBridgedClass`, whose PASS B
/// fuzzy fallback claims any bridge whose name is a >=3-character prefix of
/// the native type name — so `TextDirection` resolved to the `Text` *widget*,
/// and the declared-parameter check in `callable.dart` then rejected correct
/// calls with `type 'Text' is not a subtype of type 'TextDirection' of 'dir'`.
///
/// ## Why this exists when SCC46 already has three regression tests
///
/// Those pin the mechanism with a hand-built two-bridge fixture (`Text` +
/// `TextDirection`). A fixture proves the branch works for the pair its author
/// thought of. It says nothing about the registry where the defect actually
/// lived — and the registry is the whole point: one short bridge name captures
/// as many enums as happen to extend it.
///
/// This file asserts the property over the **real** environment a script
/// resolves names in, and does it in about a second. SCC46 was found four
/// corpus files into a sixteen-minute suite that needs a companion app and a
/// local HTTP server.
///
/// ## Measured — the registry, then the ablation under two interpreters
///
/// Flutter 3.44.6. The first three rows are built by this package's BRIDGES
/// and do not move with the interpreter — both columns below measured them
/// identically. The ablation rows are the interpreter's answer, and they do
/// move.
///
/// | measurement                                                   | value |
/// | ------------------------------------------------------------- | ----: |
/// | bridged enums reachable                                       |   151 |
/// | native enum values across them                                |   589 |
/// | enums shadowed by a >=3-char-prefix bridged CLASS name        |    80 |
/// | ablation: resolved CORRECTLY by the class path — both columns |     0 |
/// | ablation: silently mistyped — hosted `tom_d4rt` 1.77.0        |    82 |
/// | ablation: unclaimed, i.e. throws — hosted 1.77.0              |    69 |
/// | ablation: silently mistyped — working tree 1.176.0            |     0 |
/// | ablation: unclaimed, i.e. throws — working tree 1.176.0       |   151 |
///
/// The `correct` row is the finding, and it is a stronger statement than the
/// count of failures SCC46 happened to produce: `toBridgedClass` resolves
/// **no** bridged enum correctly, because a bridged enum is registered in the
/// environment's enum table and never in its class table. The enum branch is
/// not a patch for a handful of colliding names; it is the only thing that
/// resolves any of them. It holds under both interpreters.
///
/// **SCD132 eliminated the silent-mistype outcome entirely.** Under the
/// published interpreter 82 of the 151 come back as a DIFFERENT bridge;
/// under the working tree none do — all 151 throw. That is PASS B's
/// narrowing, which now requires a prefix match to be corroborated by
/// `nativeNames` or a supertype-registry edge, and it is worth stating
/// plainly: with the enum branch ablated the class path no longer returns a
/// wrong answer, it returns no answer. The failure a regression would produce
/// has changed from `type 'Text' is not a subtype of type 'TextDirection'`,
/// raised ten frames from the cause by the declared-parameter check in
/// `callable.dart`, into an error naming the unclaimed type at the point it
/// was asked about. F-SCD133-4 asserts only `correct == 0` precisely so that
/// this improvement does not read as a regression; both columns satisfy it.
///
/// **Which interpreter a column describes is load-bearing.** Both twins
/// resolve the interpreter from pub.dev (DGUC6), so an ordinary run here
/// measures the PUBLISHED one. The working-tree column was taken under the
/// SCD66 pre-publish pass (`tom_d4rt_flutter_ast/tool/prepublish_overrides.dart
/// --set`, restored afterwards) and is therefore not a recordable verification
/// run — it is stated here as what the next publish will make the hosted
/// column say.
///
/// **The hosted split recorded here was measured and still holds** — 82 / 69,
/// unchanged. The AST twin's did not: it stated 103 / 110 against a measured
/// 104 / 109, a pair that sums correctly and reproduces exactly what deriving
/// the split from the prefix-shadowed row by hand would give. The two are
/// different questions — `shadowed` asks whether some >=3-character prefix of
/// the ENUM's name is a registered class, the ablation asks what
/// `toBridgedClass` returns for the native VALUE's runtime type — and on this
/// line the numbers differ (82 against 80), which is why the conflation had
/// nowhere to hide here.
///
/// Every number above is now `print`ed by F-SCD133-1, -2 and -4 on a green
/// run, so refreshing this table costs one `flutter test` of this file and no
/// edit. That is the whole reason the drift above could be found at all.
///
/// The floors below were re-checked against these counts and left alone:
/// 120/450/60 against 151/589/80 here and 213/857/103 on the AST twin,
/// so the tightest margin is this line's own 80 against 60. They exist to catch a
/// registry that did not load, not to track the counts.
///
/// ## F-SCD133-3 compares IDENTITY, and that was measured before it was chosen
///
/// The obvious assertion is `resolved.name == registered.name`, and it is too
/// weak here for a reason specific to this registry: measured 2026-09-23, 151
/// of the 213 enums are declared in TWO frames of the environment chain. A name
/// match is therefore satisfiable by a second, equivalent registration — which
/// would be a duplicate-registration defect that the name check cannot see at
/// all. All 213 resolve to the very object `env.get(name)` returns, because
/// registration is pooled and the two frames hold one instance, so identity is
/// available as well as stronger.
///
/// Ablated rather than argued: replacing the held definition with a distinct
/// object of the same name turns F-SCD133-3 RED under identity and leaves it
/// GREEN under name equality. That pair is the whole case for the choice.
///
/// ## Why the twins report different numbers
///
/// The same 18 bridge files, the same script, two different counts (151 here,
/// 213 in `tom_d4rt_flutter_ast`). On this line a bridged enum appears only
/// once an import brings it in — `material.dart` alone yields 151, and a
/// script importing nothing sees zero; on the AST line the runner dumps every
/// bridged enum into the warm-parent baseline regardless. Each twin therefore
/// guards the registry its own interpreter actually builds, which is the
/// honest thing for it to do; the floors below are set to hold for both.
///
/// SCE151 SETTLED WHAT THAT DIVERGENCE IS, and it is not enum-specific: with
/// no import the AST line reaches 2414 bridged CLASSES against this line's 84,
/// so the classes diverge harder than the enums. Its baseline was disabled and
/// its base corpus re-run to price a tightening: 926/1/1 becomes 851/1/25. The
/// twenty-four are not scripts using an unimported NAME — they fail with
/// `No bridge claims this type` for native values returned from bridged calls
/// (`PlatformDispatcher`, `SemanticsFlag`, `DeviceGestureSettings`), whose
/// types no import ever named. That baseline is the AST line's mechanism for
/// bridging a transitively-reached type, not laxity about imports, and it
/// stands as a deliberate allowance. This line reaches those types through
/// what `material.dart`'s import registers. See
/// `_copilot_guidelines/d4rt/mirror_maintenance.md`.
///
/// Twin of
/// `tom_d4rt_flutter_ast/test/scd133_registry_enum_resolution_test.dart`.
/// The two differ only in how the throwaway script reaches the interpreter —
/// raw source here, a compiled `AstBundle` there.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

/// A script that imports what essentially every corpus script imports, so the
/// environment under test is one a real build produces rather than a bare
/// interpreter. The body is deliberately trivial: this file is about what the
/// *registry* resolves to, not about executing anything.
const String _probeScript = '''
import 'package:flutter/material.dart';

int main() => 1;
''';

/// Floors, not equalities. The exact counts move with every Flutter SDK bump
/// and every bridge regeneration; the order of magnitude must not. A floor
/// catches the one failure this guard is most exposed to — a registry that did
/// not load, which would make every "for each registered enum" assertion below
/// pass by iterating nothing.
const int _minBridgedEnums = 120; // measured 151 here, 213 on the AST twin
const int _minEnumValues = 450; // measured 589 here, 857 on the AST twin
const int _minPrefixCollisions = 60; // measured 80 here, 103 on the AST twin

/// Pairs observed capturing each other in the 2026-09-05 SCC46 inventory, each
/// re-verified against the live registry of both twins. Named rather than
/// merely counted: if Flutter renames or drops one, this reports which, instead
/// of nudging a total nobody can interpret.
const Map<String, String> _historicalCaptures = <String, String>{
  'TextDirection': 'Text',
  'TextAlign': 'Text',
  'TextOverflow': 'Text',
  'TextBaseline': 'Text',
  'TextLeadingDistribution': 'Text',
  'ThemeMode': 'Theme',
  'BorderStyle': 'Border',
  'FlexFit': 'Flex',
  'KeyEventResult': 'Key',
  'WidgetState': 'Widget',
};

/// One registered bridged enum, reduced to what this file asserts about it.
class _RegisteredEnum {
  _RegisteredEnum(this.name, this.definition, this.nativeValues);

  final String name;

  /// The `BridgedEnum` `env.get(name)` returned — held as `Object` for the
  /// same reason the lookup is `dynamic` (see [_collectEnums]). F-SCD133-3
  /// compares against THIS rather than against [name].
  final Object definition;

  final List<Object> nativeValues;
}

/// Builds the real environment and returns every bridged enum reachable from
/// it.
///
/// The environment is taken from the visitor AFTER the probe script has run,
/// so it is the same object a real build resolves names against rather than a
/// reconstruction. `warmup()` would not do: it builds the warm parent but
/// leaves the visitor unset.
///
/// Exactly one [SourceFlutterD4rt] is constructed, and that matters. Bridge
/// registration is pooled per process, so a *second* instance skips it and its
/// own registries stay empty.
(Environment, List<_RegisteredEnum>) _liveRegistry() {
  final d4rt = SourceFlutterD4rt();
  d4rt.execute<int>(_probeScript, name: 'main');

  final env = d4rt.interpreter.visitor!.globalEnvironment;
  return (env, _collectEnums(env));
}

/// Walks the environment chain collecting every registered bridged enum.
///
/// `bridgedEnumNames` reports a single frame, and the definitions live in the
/// warm parent — so the chain has to be walked to see them from the child the
/// script runs in.
///
/// `dynamic` rather than `BridgedEnum`, and it is not an oversight.
/// `tom_d4rt/d4rt.dart` gained that export in 1.109.0; both twins resolve
/// their interpreter from pub.dev (DGUC6) and `tom_d4rt_flutter` still
/// declares `tom_d4rt: "^1.77.0"`, so the source line cannot name the type
/// yet. Typing only the AST twin would make the two files diverge for a reason
/// unrelated to what they assert, which is the thing this pair exists not to
/// do — so both wait, together.
///
/// The wait is not left to memory: when that floor moves past 1.109.0,
/// `tom_d4rt_flutter_ast/test/sce157_typed_registry_pending_test.dart` goes
/// red and says to type both files.
List<_RegisteredEnum> _collectEnums(Environment env) {
  final names = <String>{};
  for (Environment? frame = env; frame != null; frame = frame.enclosing) {
    names.addAll(frame.bridgedEnumNames);
  }

  final collected = <_RegisteredEnum>[];
  for (final name in names.toList()..sort()) {
    final dynamic bridgedEnum = env.get(name);
    final Object? valueMap = bridgedEnum?.values;
    if (valueMap is! Map) {
      fail(
        'registry inventory: `$name` is listed by bridgedEnumNames but '
        '`env.get("$name")` did not yield a bridged enum (got '
        '${bridgedEnum.runtimeType}). Every assertion below reads the registry '
        'through this path, so a hole here is a hole in all of them.',
      );
    }
    collected.add(
      _RegisteredEnum(name, bridgedEnum as Object, <Object>[
        for (final dynamic value in valueMap.values)
          value.nativeValue as Object,
      ]),
    );
  }
  return collected;
}

/// The shortest registered bridged CLASS name that is a >=3-character prefix of
/// [enumName] — exactly what PASS B's fuzzy fallback latches onto.
String? _capturingClassName(Environment env, String enumName) {
  for (var length = 3; length < enumName.length; length++) {
    final candidate = enumName.substring(0, length);
    if (env.findBridgedClassByName(candidate) != null) return candidate;
  }
  return null;
}

void main() {
  late Environment env;
  late List<_RegisteredEnum> enums;

  setUpAll(() {
    (env, enums) = _liveRegistry();
  });

  group('SCD133: registry-wide bridged-enum resolution', () {
    test('F-SCD133-1: the registry loaded — enough enums and values for the '
        'per-enum assertions to mean anything', () {
      final valueCount = enums.fold<int>(
        0,
        (running, e) => running + e.nativeValues.length,
      );

      // `print`, not `printOnFailure`: the table in this file's header is
      // DERIVED from these numbers, so refreshing it has to be something a
      // run does rather than something a reader re-derives by patching the
      // file. A measurement that surfaces only on failure cannot do that, and
      // a header table nobody can cheaply re-measure is how one goes
      // historical without anyone noticing.
      // ignore: avoid_print
      print(
        'SCD133 inventory: ${enums.length} bridged enums, '
        '$valueCount native values',
      );

      expect(
        enums.length,
        greaterThanOrEqualTo(_minBridgedEnums),
        reason:
            'a "for every registered enum" assertion over an empty or '
            'half-built registry passes by iterating nothing. This floor is '
            'what makes F-SCD133-3 a claim rather than a tautology.',
      );

      expect(
        valueCount,
        greaterThanOrEqualTo(_minEnumValues),
        reason:
            'enums were found but carry no values, so the per-value loop '
            'below would iterate nothing',
      );
    });

    test(
      'F-SCD133-2: the collision hazard is present here — short bridged class '
      'names still shadow longer enum names',
      () {
        final registered = {for (final e in enums) e.name};

        final gone = <String>[];
        _historicalCaptures.forEach((enumName, capturingClass) {
          if (!registered.contains(enumName)) {
            gone.add('enum `$enumName` is no longer registered');
          } else if (env.findBridgedClassByName(capturingClass) == null) {
            gone.add('class `$capturingClass` is no longer registered');
          }
        });
        expect(
          gone,
          isEmpty,
          reason:
              'these pairs ARE the SCC46 failure mode. If one end stops being '
              'registered, F-SCD133-3 keeps passing while covering strictly '
              'less — so name which end went rather than let the guard '
              'quietly narrow:\n  ${gone.join('\n  ')}',
        );

        final shadowed = <String>[
          for (final e in enums)
            if (_capturingClassName(env, e.name) != null) e.name,
        ];
        // ignore: avoid_print
        print('SCD133 inventory: ${shadowed.length} prefix-shadowed enums');

        expect(
          shadowed.length,
          greaterThanOrEqualTo(_minPrefixCollisions),
          reason:
              'only ${shadowed.length} registered enums are shadowed by a '
              '>=3-char-prefix bridged class name. The hazard this guards is '
              'proportional to that number; if it has genuinely collapsed, '
              'lower the floor deliberately rather than by accident.',
        );
      },
    );

    test('F-SCD133-3: every registered bridged enum value resolves to its own '
        'enum, never to a bridged class whose name is a prefix of it', () {
      // Collect ALL violations. The first is rarely the informative one:
      // SCC46 presented as 131 failures sharing a single signature, and the
      // shape of that set is what identified it.
      final violations = <String>[];
      for (final registered in enums) {
        for (final nativeValue in registered.nativeValues) {
          final resolved = env.getRuntimeType(nativeValue);
          if (resolved == null) {
            violations.add('${registered.name}: $nativeValue -> <null>');
          } else if (!identical(resolved, registered.definition)) {
            final sameName = resolved.name == registered.name;
            violations.add(
              '${registered.name}: $nativeValue -> '
              '${sameName ? 'a DIFFERENT object of the same name '
                        '(@${identityHashCode(resolved)} vs '
                        '@${identityHashCode(registered.definition)})' : resolved.name}'
              '${resolved is BridgedClass ? ' (a bridged CLASS)' : ''}',
            );
          }
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            '${violations.length} native enum value(s) resolve to the wrong '
            'runtime type. Wherever `getRuntimeType` is consulted — the '
            'declared-parameter check in `callable.dart` is the loudest '
            'consumer — these turn correct code into "type X is not a '
            'subtype of type Y". The comparison is IDENTITY, not name '
            'equality: 151 of the 213 enums here are declared in two frames of '
            'the chain, so a name match can be satisfied by a second, '
            'equivalent registration — which would be a duplicate-registration '
            'defect that a name check cannot see. Measured 2026-09-23, all 213 '
            'resolve to the very object `env.get(name)` returns, because '
            'registration is pooled and both frames hold one instance:\n  '
            '${violations.take(40).join('\n  ')}',
      );
    });

    test('F-SCD133-4: the enum branch is load-bearing for the WHOLE registry — '
        'the bridged-class path resolves none of these enums', () {
      // A live ablation: this is what `getRuntimeType` would fall through to
      // if SCC46's `value is Enum` branch were deleted today.
      var probed = 0;
      var correct = 0;
      var mistyped = 0;
      var unclaimed = 0;
      final examples = <String>[];

      for (final registered in enums) {
        if (registered.nativeValues.isEmpty) continue;
        probed++;
        final native = registered.nativeValues.first;
        try {
          final viaClassPath = env.toBridgedClass(native.runtimeType);
          if (viaClassPath.name == registered.name) {
            correct++;
          } else {
            mistyped++;
            if (examples.length < 8) {
              examples.add('${registered.name} -> ${viaClassPath.name}');
            }
          }
        } catch (_) {
          // No bridge claims the native type at all — the honest outcome.
          unclaimed++;
        }
      }

      expect(
        probed,
        greaterThanOrEqualTo(_minBridgedEnums),
        reason: 'the ablation must actually run over the registry',
      );
      expect(
        correct,
        0,
        reason:
            'the class-resolution path resolved $correct bridged enum(s) '
            'correctly. It must resolve NONE: a bridged enum is registered '
            "in the environment's enum table, never in its class table. If "
            'this is no longer 0 the registry has changed shape and the '
            'reasoning in this file needs re-deriving, not the number '
            'nudging.',
      );

      // The mistyped/unclaimed split is reported, not asserted. scd132
      // narrowed PASS B so that some enums now throw instead of returning a
      // wrong bridge, which moves entries from `mistyped` to `unclaimed`
      // without changing the conclusion — and an assertion on the split
      // would go red on that improvement. What matters is that neither
      // bucket is a correct answer, which `correct == 0` already says.
      //
      // It is `print` for the reason given in F-SCD133-1: this split is the
      // last row of the header table, and the split is exactly the number
      // scd132 was expected to move. Under `printOnFailure` it was invisible
      // on every green run — which is every run — so the only way to read it
      // was to edit this file first.
      // ignore: avoid_print
      print(
        'SCD133 ablation over $probed enums: $correct correct, '
        '$mistyped silently mistyped, $unclaimed unclaimed. '
        'Examples: ${examples.join(', ')}',
      );
    });
  });
}
