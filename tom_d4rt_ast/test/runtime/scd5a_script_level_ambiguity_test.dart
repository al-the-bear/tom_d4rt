/// SCD5 (scd5_aicv) — bridged-name resolution asserted the way the corpus
/// asks it: does a SCRIPT that names the class get the right one?
///
/// tcca19 (tom_d4rt_ast 0.19.0) made two same-named bridged classes reject the
/// bare name, platform declarations included. It broke 17 of the 927 base-corpus
/// scripts with `Ambiguous Name Error: TextStyle` — `dart:ui`'s and painting's —
/// and shipped with every unit test green, because every ambiguity test built
/// an `Environment` by hand and asked what the registry decided about
/// candidates the test itself supplied. None ran a script. This file does:
/// each case registers bridges on a real `D4rtRunner`, runs a bundle whose
/// entry module carries real import directives, and asserts which class the
/// script's bare name reached.
///
/// F-SCD5A-AST-1 is the regression itself, in the shape the corpus met it:
/// `cupertino/contextmenu_test.dart` imports cupertino, foundation and
/// material, none of whose recorded surfaces carry `TextStyle`, so the name
/// comes from the runner's baseline — where `dart:ui` and painting both
/// declare it. Measured red when platform precedence is disabled
/// (`Environment._peersAfterPlatformPrecedence` returning every candidate),
/// with the same `Ambiguous Name Error` the corpus reported.
///
/// The package-vs-package half of the rule — a script importing one of two
/// packages gets that package's class — is `scd4a_ambiguity_import_scope_test`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class _UiTextStyle {}

class _PaintingTextStyle {}

class _PackageDuration {}

void main() {
  const uiLib = 'dart:ui';
  const paintingSrc = 'package:flutter/src/painting/text_style.dart';
  const material = 'package:flutter/material.dart';
  const cupertino = 'package:flutter/cupertino.dart';
  const foundation = 'package:flutter/foundation.dart';
  const widgets = 'package:flutter/widgets.dart';

  var offset = 0;
  int next() => offset += 5;

  /// A bridged class whose static `origin()` names which declaration it is.
  BridgedClass declaring(String name, Type nativeType, String origin) =>
      BridgedClass(
        nativeType: nativeType,
        name: name,
        staticMethods: {
          'origin': (visitor, positional, named, typeArgs) => origin,
        },
      );

  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  /// The Flutter shape: `TextStyle` declared by `dart:ui` and by painting;
  /// `widgets` re-exports painting's (same class, painting's source URI);
  /// material re-exports `dart:ui`'s `Color` but not `TextStyle` — as
  /// `package:flutter/painting.dart`'s `export 'dart:ui' show ...` makes it do —
  /// and cupertino / foundation carry only markers.
  ///
  /// The `Color` re-export is load-bearing. It puts `dart:ui` among the
  /// packages the script's imports reach, so import-scope narrowing
  /// (scd4_aicv) leaves both candidates standing and only platform precedence
  /// can settle `TextStyle`. Without it the narrowing alone would, and
  /// F-SCD5A-AST-1 would stay green with precedence removed — measured.
  D4rtRunner flutterShapedRunner() => D4rtRunner()
    ..registerBridgedClass(
      declaring('TextStyle', _UiTextStyle, 'dart:ui'),
      uiLib,
      sourceUri: uiLib,
    )
    ..registerBridgedClass(
      declaring('TextStyle', _PaintingTextStyle, 'painting'),
      paintingSrc,
      sourceUri: paintingSrc,
    )
    ..registerBridgedClass(
      declaring('TextStyle', _PaintingTextStyle, 'painting'),
      widgets,
      sourceUri: paintingSrc,
    )
    ..registerBridgedClass(
      marker('CupertinoApp'),
      cupertino,
      sourceUri: cupertino,
    )
    ..registerBridgedClass(
      marker('ChangeNotifier'),
      foundation,
      sourceUri: foundation,
    )
    ..registerBridgedClass(marker('MaterialApp'), material, sourceUri: material)
    ..registerBridgedClass(
      BridgedClass(nativeType: int, name: 'Color'),
      material,
      sourceUri: uiLib,
    );

  SImportDirective importOf(String uri) => SImportDirective(
    offset: next(),
    length: 1,
    uri: SSimpleStringLiteral(offset: next(), length: 1, value: uri),
  );

  /// `main() => <className>.origin();` under [imports].
  AstBundle bundle(List<String> imports, {String className = 'TextStyle'}) {
    const entry = 'package:t/main.dart';
    final call = SMethodInvocation(
      offset: next(),
      length: 1,
      target: SSimpleIdentifier(
        offset: next(),
        length: className.length,
        name: className,
      ),
      operator: '.',
      methodName: SSimpleIdentifier(offset: next(), length: 6, name: 'origin'),
      argumentList: SArgumentList(offset: next(), length: 2),
    );
    final mainFn = SFunctionDeclaration(
      offset: next(),
      length: 4,
      name: SSimpleIdentifier(offset: next(), length: 4, name: 'main'),
      functionExpression: SFunctionExpression(
        offset: next(),
        length: 1,
        parameters: SFormalParameterList(offset: next(), length: 1),
        body: SBlockFunctionBody(
          offset: next(),
          length: 1,
          block: SBlock(
            offset: next(),
            length: 1,
            statements: [
              SReturnStatement(offset: next(), length: 1, expression: call),
            ],
          ),
        ),
      ),
    );
    return AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: [for (final uri in imports) importOf(uri)],
          declarations: [mainFn],
        ),
      },
    );
  }

  Object? run(D4rtRunner runner, List<String> imports) =>
      runner.executeBundleAs<Object?>(bundle(imports));

  group('SCD5A/AST: a script naming TextStyle gets the right one', () {
    test('F-SCD5A-AST-1: the tcca19 shape — cupertino, foundation and '
        'material imported, TextStyle from the baseline — is painting\'s '
        '[2026-09-11] (PASS)', () {
      expect(
        run(flutterShapedRunner(), [cupertino, foundation, material]),
        'painting',
      );
    });

    test('F-SCD5A-AST-2: importing dart:ui alongside the package that '
        'exports TextStyle still means painting\'s, in either order '
        '[2026-09-11] (PASS)', () {
      // Legal Dart; `dart analyze` only calls the dart:ui import unnecessary.
      expect(run(flutterShapedRunner(), [uiLib, widgets]), 'painting');
      expect(run(flutterShapedRunner(), [widgets, uiLib]), 'painting');
    });

    test('F-SCD5A-AST-3: a script importing only dart:ui gets dart:ui\'s '
        'TextStyle [2026-09-11] (PASS)', () {
      expect(run(flutterShapedRunner(), [uiLib]), 'dart:ui');
    });

    test('F-SCD5A-AST-4: an imported package class shadows the ambient '
        'dart:core one of the same name — tcca19\'s stated invariant '
        '[2026-09-11] (PASS)', () {
      // "Import-over-ambient is unaffected — only import-vs-import is
      // ambiguous" was the commit's own claim, and nothing asserted it.
      const pkg = 'package:timekeeping/timekeeping.dart';
      final runner = D4rtRunner()
        ..registerBridgedClass(
          declaring('Duration', _PackageDuration, 'timekeeping'),
          pkg,
          sourceUri: 'package:timekeeping/src/duration.dart',
        );
      expect(
        runner.executeBundleAs<Object?>(bundle([pkg], className: 'Duration')),
        'timekeeping',
      );
    });
  });
}
