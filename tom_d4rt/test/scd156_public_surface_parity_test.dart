// REPO-WIDE GUARD (tom_d4rt) — the two interpreter lines' public libraries
// withhold nothing they hold.
//
// WHAT THIS IS ABOUT. `tom_d4rt_exec/lib/d4rt.dart` re-exports
// `package:tom_d4rt_ast/runtime.dart` WHOLESALE; `tom_d4rt/lib/d4rt.dart`
// exports a list of `src/` libraries by hand. Two surfaces meant to be
// interchangeable to a caller, built by opposite methods — so the obvious worry
// is that the hand-written one withholds something the wholesale one exports,
// and that a conformance port therefore cannot import the same public library
// its reference does.
//
// MEASURED, AND THE WORRY IS UNFOUNDED IN BOTH DIRECTIONS. The two surfaces are
// 149 and 342 names. Of the 199 that `tom_d4rt_exec/d4rt.dart` exports and
// `tom_d4rt/d4rt.dart` does not, ZERO are declared anywhere in `tom_d4rt/lib`:
// every one is an analyzer-free-line concept — the mirror AST (`SAstNode` and
// its 180-odd subtypes), `D4rtRunner`, `AstBundle`, `ModuleContext`,
// `AstBundler`. And of the six names `tom_d4rt/d4rt.dart`
// exports that exec's does not — `BarrelMapping`, `D4rtUserProxy`,
// `D4rtUserRelaxer`, `LibraryBridgeDefinition`, `ModuleBridgeInfo`,
// `StaticCoord` — all six are absent from `tom_d4rt_ast` entirely. Neither side
// is withholding; the two lines simply implement different things.
//
// SO WHAT IS ASSERTED is the property that made the worry worth checking: a
// name one package DECLARES and the other EXPORTS must be exported by both. The
// interesting moment is not today, it is when somebody adds a type to the
// analyzer-free runtime, mirrors it into `tom_d4rt/lib/src/`, and forgets the
// one line in `d4rt.dart` — at which point the next port of a test using it
// stops compiling, and nothing else would have said why.
//
// THE SUPPRESSION THIS RETIRED. SCC52 added
// `tom_d4rt_exec/test/analysis_options.yaml` turning off `unnecessary_import`
// for exec's whole test tree, on the reasoning that a port reaching into
// `package:tom_d4rt/src/...` for a type exec's public library re-exports must
// carry a redundant-looking import. The named instance was
// `scc46_native_enum_runtime_type_test.dart` and `BridgedEnumDefinition` —
// which `tom_d4rt/d4rt.dart` exports (from `src/bridge/registration.dart`, not
// from `src/bridge/bridged_enum.dart` where the todo looked for it). Both
// copies of that file now import only their public library, `dart analyze test`
// is clean without the override, and the override is gone. The lint is still
// on: adding the `src/` import back to exec's copy reproduces it.
//
// PARSE, NOT RESOLVE. The namespaces are computed by walking `export`
// directives with their `show` / `hide` combinators and collecting public
// top-level declarations — no element model, no package config, so this costs a
// parse of two `lib/` trees rather than a resolution of them. It cannot see a
// name re-exported through a `dart:` or third-party library, which is why the
// control below pins the sizes.
@TestOn('vm')
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:test/test.dart';

import 'sibling_trees.dart';

/// `parseFile` demands an absolute, NORMALISED path -- a `..` segment anywhere
/// in it raises rather than being resolved -- and every sibling root below
/// carries one.
String _real(String path) =>
    File(path).absolute.uri.normalizePath().toFilePath();

/// Package name to `lib/` directory, as seen from this package's test cwd.
const Map<String, String> _libRoots = {
  'tom_d4rt': 'lib',
  'tom_d4rt_ast': '../tom_d4rt_ast/lib',
  'tom_ast_model': '../tom_ast_model/lib',
  'tom_ast_generator': '../tom_ast_generator/lib',
  'tom_d4rt_exec': '../tom_d4rt_exec/lib',
};

/// Differences that have been looked at and accepted, name to reason.
///
/// EMPTY, and that is the measured state rather than an unfilled stub: nothing
/// either package declares is withheld by its own public library. An entry here
/// is a decision — "this name is deliberately internal on one line" — and it
/// belongs beside the export list it is about as well.
const Map<String, String> _acceptedAsymmetry = <String, String>{};

String? _resolve(String uri, String fromFile) {
  if (uri.startsWith('dart:')) return null;
  if (!uri.startsWith('package:')) {
    return '${File(fromFile).parent.path}/$uri';
  }
  final rest = uri.substring('package:'.length);
  final slash = rest.indexOf('/');
  final root = _libRoots[rest.substring(0, slash)];
  return root == null ? null : '$root/${rest.substring(slash + 1)}';
}

Set<String> _declaredIn(String path) {
  if (!File(path).existsSync()) return const {};
  final unit = parseFile(
    path: _real(path),
    featureSet: FeatureSet.latestLanguageVersion(),
  ).unit;
  final names = <String>{};
  for (final declaration in unit.declarations) {
    if (declaration is NamedCompilationUnitMember) {
      names.add(declaration.name.lexeme);
    } else if (declaration is TopLevelVariableDeclaration) {
      for (final variable in declaration.variables.variables) {
        names.add(variable.name.lexeme);
      }
    }
  }
  for (final directive in unit.directives) {
    if (directive is PartDirective) {
      final part = _resolve(directive.uri.stringValue ?? '', path);
      if (part != null) names.addAll(_declaredIn(part));
    }
  }
  return names.where((n) => !n.startsWith('_')).toSet();
}

/// Every name a caller reaching for [path] can see.
Set<String> _namespace(String path, [Set<String>? seen]) {
  seen ??= <String>{};
  if (!File(path).existsSync()) return const {};
  if (!seen.add(File(path).absolute.path)) return const {};
  final names = _declaredIn(path);
  final unit = parseFile(
    path: _real(path),
    featureSet: FeatureSet.latestLanguageVersion(),
  ).unit;
  for (final directive in unit.directives) {
    if (directive is! ExportDirective) continue;
    final target = _resolve(directive.uri.stringValue ?? '', path);
    if (target == null) continue;
    var exported = _namespace(target, seen);
    for (final combinator in directive.combinators) {
      if (combinator is ShowCombinator) {
        final shown = combinator.shownNames.map((i) => i.name).toSet();
        exported = exported.where(shown.contains).toSet();
      } else if (combinator is HideCombinator) {
        final hidden = combinator.hiddenNames.map((i) => i.name).toSet();
        exported = exported.where((n) => !hidden.contains(n)).toSet();
      }
    }
    names.addAll(exported);
  }
  return names;
}

/// Every public top-level name declared anywhere under [root].
Set<String> _declaredUnder(String root) {
  final directory = Directory(root);
  if (!directory.existsSync()) return const {};
  final names = <String>{};
  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      names.addAll(_declaredIn(entity.path));
    }
  }
  return names;
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt',
    subject: "both interpreter lines' public libraries",
  );

  final skip =
      Directory('../tom_d4rt_ast/lib').existsSync() &&
          Directory('../tom_d4rt_exec/lib').existsSync()
      ? null
      : 'needs the sibling checkouts ../tom_d4rt_ast and ../tom_d4rt_exec; '
            'this guard compares two package surfaces and cannot run from a '
            'published tom_d4rt on its own';

  group('SCD156: neither public library withholds what its package holds', () {
    late Set<String> reference;
    late Set<String> twin;
    late Set<String> referenceDeclared;
    late Set<String> twinDeclared;

    setUp(() {
      if (skip != null) return;
      reference = _namespace('lib/d4rt.dart');
      // EXEC's public library, not the AST twin's `runtime.dart`, because that
      // is what a conformance port imports. The difference is not cosmetic:
      // exec adds its own front end on top — `D4rt` itself lives in
      // `tom_d4rt_exec/lib/src/d4rt_base.dart`, so comparing against
      // `runtime.dart` alone reports the interpreter class as missing from the
      // analyzer-free line, which is exactly backwards.
      twin = _namespace('../tom_d4rt_exec/lib/d4rt.dart');
      referenceDeclared = _declaredUnder('lib');
      twinDeclared = {
        ..._declaredUnder('../tom_d4rt_ast/lib'),
        ..._declaredUnder('../tom_d4rt_exec/lib'),
      };
    });

    test('F-SCD156-1: tom_d4rt exports every name it declares that the '
        'exec surface exports [2026-09-15]', () {
      final withheld =
          twin
              .difference(reference)
              .where(referenceDeclared.contains)
              .where((n) => !_acceptedAsymmetry.containsKey(n))
              .toList()
            ..sort();
      expect(
        withheld,
        isEmpty,
        reason:
            'These names are exported by `tom_d4rt_exec/d4rt.dart` — which '
            're-exports `tom_d4rt_ast/runtime.dart` wholesale — and ARE '
            'declared in '
            '`tom_d4rt/lib`, but `tom_d4rt/lib/d4rt.dart` does not export '
            'them.\n\n'
            'The cost is paid by the conformance corpus: a reference test '
            'needing one has to reach into `package:tom_d4rt/src/...`, its '
            'port then has a redundant import against exec\'s wider surface, '
            'and buying that back costs either a `_divergentBaseline` entry '
            '(which absorbs every future divergence in the file) or a lint '
            'suppression over the whole test tree. SCC52 paid the second; '
            'SCD156 retired it.\n\n'
            'Export the name from `lib/d4rt.dart` and bump the minor version, '
            'or — if it is deliberately internal — record it in '
            '`_acceptedAsymmetry` AND say so beside the export list, so the '
            'next port knows the `src/` import is intentional.\n'
            '${withheld.join('\n')}',
      );
    }, skip: skip);

    test('F-SCD156-2: the exec surface exports every name it declares that '
        'tom_d4rt exports [2026-09-15]', () {
      final missing =
          reference
              .difference(twin)
              .where(twinDeclared.contains)
              .where((n) => !_acceptedAsymmetry.containsKey(n))
              .toList()
            ..sort();
      expect(
        missing,
        isEmpty,
        reason:
            'The mirror direction. These names are public API on the '
            'analyzer-based line and are declared in the analyzer-free line '
            'too, but `tom_d4rt_exec/d4rt.dart` does not export them — so a port of a test using '
            'one cannot compile against `tom_d4rt_exec/d4rt.dart` at all, '
            'which is worse than a lint.\n'
            '${missing.join('\n')}',
      );
    }, skip: skip);

    test('F-SCD156-3 (control): both namespaces were actually read '
        '[2026-09-15]', () {
      // The emptiness above is what a parser that read nothing also reports,
      // and this file's whole method is a hand-rolled export walk over another
      // package's source — exactly the input that degrades silently when a
      // directive form changes. Measured 2026-09-15: 149 / 332 exported, and
      // the two `lib/` trees declare far more than they export.
      expect(
        reference.length,
        greaterThan(100),
        reason:
            '`lib/d4rt.dart` resolved to ${reference.length} exported names '
            'where 149 were measured. The export walk has stopped following '
            'something, and F-SCD156-1 is passing over a set it cannot see.',
      );
      expect(
        twin.length,
        greaterThan(250),
        reason:
            '`tom_d4rt_exec/d4rt.dart` resolved to ${twin.length} exported '
            'names where 342 were measured.',
      );
      expect(
        referenceDeclared.length,
        greaterThan(reference.length),
        reason:
            'The package declares no more public names than it exports, which '
            'cannot be true of a package with a `src/` tree — the declaration '
            'walk has stopped reading files, and both checks above are then '
            'filtering against an empty set.',
      );
      expect(twinDeclared.length, greaterThan(twin.length));
    }, skip: skip);
  });
}
