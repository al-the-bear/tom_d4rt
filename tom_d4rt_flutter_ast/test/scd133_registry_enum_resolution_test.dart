// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — asserts a property of the
// INTERPRETER (`Environment.getRuntimeType`) across this package's entire
// bridge registry. It lives here because this is where a registry that large
// exists; the code it protects lives in `tom_d4rt_ast`.
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
/// ## Measured, tom_d4rt_ast 0.65.0 + Flutter 3.44.6
///
/// | measurement                                              | value |
/// | -------------------------------------------------------- | ----: |
/// | bridged enums reachable                                   |   213 |
/// | native enum values across them                            |   857 |
/// | enums shadowed by a >=3-char-prefix bridged CLASS name     |   103 |
/// | of the 213, resolved correctly by the CLASS path alone     |     0 |
///
/// The last row is the finding, and it is a stronger statement than the count
/// of failures SCC46 happened to produce. `toBridgedClass` resolves **no**
/// bridged enum correctly — a bridged enum is registered in the environment's
/// enum table and never in its class table — so for all 213 the class path is
/// either silently wrong (103: it returns a different type) or absent (110: it
/// throws). The enum branch is not a patch for a handful of colliding names;
/// it is the only thing that resolves any of them. F-SCD133-4 measures that
/// live rather than recalling it.
///
/// ## Why the twins report different numbers
///
/// The same 18 bridge files, the same script, two different counts (213 here,
/// 151 in `tom_d4rt_flutter`). On this line the runner dumps every bridged
/// enum into the warm-parent baseline whether or not the script imports its
/// library; on the source line the enums appear only once an import brings
/// them in — `material.dart` alone yields 151, and a script importing nothing
/// sees zero. Each twin therefore guards the registry its own interpreter
/// actually builds, which is the honest thing for it to do; the floors below
/// are set to hold for both.
///
/// SCE151 SETTLED WHAT THAT DIVERGENCE IS, and it is not enum-specific: with
/// no import this line reaches 2414 bridged CLASSES against the source line's
/// 84, so the classes diverge harder than the enums. The baseline was
/// disabled and the base corpus re-run to price a tightening: 926/1/1 becomes
/// 851/1/25. The twenty-four are not scripts using an unimported NAME — they
/// fail with `No bridge claims this type` for native values returned from
/// bridged calls (`PlatformDispatcher`, `SemanticsFlag`,
/// `DeviceGestureSettings`), whose types no import ever named. The baseline is
/// this line's mechanism for bridging a transitively-reached type, not laxity
/// about imports, and it stands as a deliberate allowance. See
/// `_copilot_guidelines/d4rt/mirror_maintenance.md`.
///
/// Twin of `tom_d4rt_flutter/test/scd133_registry_enum_resolution_test.dart`.
/// The two differ only in how the throwaway script reaches the interpreter —
/// a compiled `AstBundle` here, raw source there.
library;

import 'package:flutter_test/flutter_test.dart';
// Host-side source→bundle compiler (test-only). The runtime executes the
// resulting AstBundle; `lib/` stays analyzer-free.
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_ast/d4rt.dart';
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

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
const int _minBridgedEnums = 120; // measured 213 here, 151 on the source twin
const int _minEnumValues = 450; // measured 857 here, 589 on the source twin
const int _minPrefixCollisions = 60; // measured 103 here, 80 on the source twin

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
  _RegisteredEnum(this.name, this.nativeValues);

  final String name;
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
/// Exactly one [FlutterD4rt] is constructed, and that matters. Bridge
/// registration is pooled per process, so a *second* instance skips it and
/// reports an empty `bridgedLibraryUris` — which would leave the bundler
/// unable to skip bridged imports.
Future<(Environment, List<_RegisteredEnum>)> _liveRegistry() async {
  final d4rt = FlutterD4rt();
  final bundle = await AstBundler(
    bridgedLibraries: d4rt.interpreter.bridgedLibraryUris,
  ).createFromSource(_probeScript);
  d4rt.execute<int>(bundle, name: 'main');

  final env = d4rt.interpreter.visitor!.globalEnvironment;
  return (env, _collectEnums(env));
}

/// Walks the environment chain collecting every registered bridged enum.
///
/// `bridgedEnumNames` reports a single frame, and the definitions live in the
/// warm parent — so the chain has to be walked to see them from the child the
/// script runs in.
///
/// `dynamic` rather than `BridgedEnum`: `tom_d4rt/d4rt.dart` does not export
/// `BridgedEnum` (its AST twin does), so naming the type would make the two
/// files diverge for a reason unrelated to what they assert. scd134 closes
/// that asymmetry; both can be tightened at once then.
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
      _RegisteredEnum(name, <Object>[
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

  setUpAll(() async {
    (env, enums) = await _liveRegistry();
  });

  group('SCD133: registry-wide bridged-enum resolution', () {
    test('F-SCD133-1: the registry loaded — enough enums and values for the '
        'per-enum assertions to mean anything', () {
      expect(
        enums.length,
        greaterThanOrEqualTo(_minBridgedEnums),
        reason:
            'a "for every registered enum" assertion over an empty or '
            'half-built registry passes by iterating nothing. This floor is '
            'what makes F-SCD133-3 a claim rather than a tautology.',
      );

      final valueCount = enums.fold<int>(
        0,
        (running, e) => running + e.nativeValues.length,
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
          } else if (resolved.name != registered.name) {
            violations.add(
              '${registered.name}: $nativeValue -> ${resolved.name}'
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
            'subtype of type Y":\n  ${violations.take(40).join('\n  ')}',
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
      printOnFailure(
        'ablation over $probed enums: $mistyped silently mistyped, '
        '$unclaimed unclaimed. Examples: ${examples.join(', ')}',
      );
    });
  });
}
