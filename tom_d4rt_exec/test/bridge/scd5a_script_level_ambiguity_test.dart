/// SCD5 (scd5_aicv) — bridged-name resolution asserted from a SCRIPT.
///
/// tcca19 (tom_d4rt 1.27.0 / tom_d4rt_ast 0.19.0) made two same-named bridged
/// classes reject the bare name, platform declarations included, and broke 17
/// of the 927 base-corpus scripts with `Ambiguous Name Error: TextStyle`. Every
/// ambiguity test at the time built an `Environment` by hand and asked what the
/// registry decided about candidates it supplied itself — none executed a
/// script — so the release shipped green. The corpus was the only detector, and
/// it was measuring a stale lock.
///
/// These cases register bridges on a `D4rt`, execute source with real import
/// directives, and assert which class the bare name reached:
///
///   * F-SCD5A-1 — the TextStyle pair: `dart:ui`'s and painting's (reached
///     through `package:flutter/widgets.dart`). Imported together, in either
///     order, the bare name is painting's — Dart's platform precedence; legal
///     Dart that `dart analyze` accepts.
///   * F-SCD5A-2 — `dart:ui` alone: its own `TextStyle`.
///   * F-SCD5A-3 — tcca19's own stated invariant, "import-over-ambient is
///     unaffected": an imported package class shadows the ambient `dart:core`
///     class of the same name, and without the import `dart:core`'s is used.
///
/// The package-vs-package half is B2-CLASH-1..4 in
/// `same_name_bridge_sourceuri_test.dart`. The corpus shape itself — a name
/// that no import's surface carries, reached through a runner baseline — has
/// no counterpart here, because this interpreter's warm parent registers bridge
/// types, not names (sce24); `tom_d4rt_ast/test/runtime/
/// scd5a_script_level_ambiguity_test.dart` carries it.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

class _UiTextStyle {}

class _PaintingTextStyle {}

class _PackageDuration {}

void main() {
  const uiLib = 'dart:ui';
  const paintingSrc = 'package:flutter/src/painting/text_style.dart';
  const widgets = 'package:flutter/widgets.dart';

  /// A bridged class whose static `origin()` names which declaration it is.
  BridgedClass declaring(String name, Type nativeType, String origin) =>
      BridgedClass(
        nativeType: nativeType,
        name: name,
        staticMethods: {
          'origin': (visitor, positional, named, typeArgs) => origin,
        },
      );

  D4rt textStyleInterpreter() => D4rt()
    ..registerBridgedClass(
      declaring('TextStyle', _UiTextStyle, 'dart:ui'),
      uiLib,
      sourceUri: uiLib,
    )
    ..registerBridgedClass(
      declaring('TextStyle', _PaintingTextStyle, 'painting'),
      widgets,
      sourceUri: paintingSrc,
    );

  String script(List<String> imports, String body) =>
      '${imports.map((uri) => "import '$uri';").join('\n')}\n'
      'String main() => $body;\n';

  group(
    'SCD5A: a script naming a shared bridged name gets the right class',
    () {
      test('F-SCD5A-1: dart:ui and the package that exports TextStyle, '
          'imported together in either order, mean painting\'s '
          '[2026-09-11] (PASS)', () {
        expect(
          textStyleInterpreter().execute(
            source: script([uiLib, widgets], 'TextStyle.origin()'),
          ),
          'painting',
        );
        expect(
          textStyleInterpreter().execute(
            source: script([widgets, uiLib], 'TextStyle.origin()'),
          ),
          'painting',
        );
      });

      test('F-SCD5A-2: a script importing only dart:ui gets dart:ui\'s '
          'TextStyle [2026-09-11] (PASS)', () {
        expect(
          textStyleInterpreter().execute(
            source: script([uiLib], 'TextStyle.origin()'),
          ),
          'dart:ui',
        );
      });

      test(
        'F-SCD5A-3: an imported package class shadows the ambient dart:core '
        'one; without the import dart:core\'s is used [2026-09-11] (PASS)',
        () {
          const pkg = 'package:timekeeping/timekeeping.dart';
          D4rt interpreter() => D4rt()
            ..registerBridgedClass(
              declaring('Duration', _PackageDuration, 'timekeeping'),
              pkg,
              sourceUri: 'package:timekeeping/src/duration.dart',
            );
          expect(
            interpreter().execute(source: script([pkg], 'Duration.origin()')),
            'timekeeping',
          );
          expect(
            interpreter().execute(
              source: script(
                const [],
                "Duration(seconds: 2).inSeconds.toString()",
              ),
            ),
            '2',
          );
        },
      );
    },
  );
}
