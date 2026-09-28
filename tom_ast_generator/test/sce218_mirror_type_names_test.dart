/// SCE218 — every mirror type in `tom_ast_model` is `S` + the analyzer's name,
/// or is recorded here with the reason it is not.
///
/// The architecture rule is that `tom_ast_model` is a 1:1 mirror of the
/// analyzer AST, and SCD183's mirror guard makes it executable by rewriting
/// the twin's `SFoo` to `Foo` before comparing the interpreters. A type named
/// otherwise escapes that rewrite, so an interpreter method over it reads as
/// divergent in a file nobody changed. Nothing checked the convention; this
/// does.
///
/// THE ORACLE, and why the two SCD183 tried were wrong. The analyzer's public
/// node types are declared as `abstract final class Foo` / `sealed class Foo`
/// in `src/dart/ast/ast.dart`; the implementations beside them are
/// `FooImpl`. Matching only a bare `class` finds the implementations, and the
/// `show` clause of `dart/ast/ast.dart` is not the whole surface. This reads
/// every non-`Impl` class declaration whatever its modifiers — 238 in analyzer
/// 10.2.0 — and pairs each `SFoo` in the model with `Foo`.
///
/// It lives HERE rather than in `tom_ast_model`, which has no dependencies and
/// so cannot see the analyzer. This package depends on both and is the one
/// that performs the analyzer-to-model mapping. Both are read through this
/// package's own resolution, so it measures the model the copier uses.
///
/// MEASURED 2026-09-28: 188 model classes, 180 conforming, and the eight below.
/// None was renamed. The serialized bundle carries these names on the wire
/// (`nodeType: 'TypedefDeclaration'`, and a shipped bundle asset contains it),
/// so a rename breaks every existing bundle or needs a permanent decode alias —
/// a second name for one node — and three of the four node mismatches are not
/// renames at all: the model has one node where the analyzer has two concrete
/// subtypes, so there is no single analyzer name to rename to.
library;

import 'dart:io';
import 'dart:isolate';

import 'package:test/test.dart';

/// Model classes that are not `S` + an analyzer AST class name, with the
/// reason each is allowed to be.
const Map<String, String> _recorded = {
  // Node mirrors that do not follow the convention.
  'STypedefDeclaration':
      'mirrors TypeAlias, and collapses its two concrete subtypes '
      '(FunctionTypeAlias, GenericTypeAlias) into one node; the '
      "interpreters' visitTypeAlias / visitTypedefDeclaration split in "
      'SCD183 follows from this name.',
  'SOnClause':
      "one node for the analyzer's MixinOnClause and ExtensionOnClause, "
      'which older analyzers named OnClause.',
  'SRecordTypeField':
      'one node for RecordTypeAnnotationNamedField and '
      'RecordTypeAnnotationPositionalField (base RecordTypeAnnotationField).',
  'SForEachStatement':
      "mirrors the analyzer's long-removed ForEachStatement; nothing produces "
      'it any more, but its nodeType stays readable on the wire.',
  // Not AST node mirrors.
  'SAstVisitor':
      "mirrors AstVisitor, which the analyzer declares in ast.g.dart rather "
      'than ast.dart — conforming, outside the oracle file.',
  'SToken':
      'mirrors Token, which comes from _fe_analyzer_shared rather than the '
      'analyzer AST.',
  'SAstNodeFactory': 'model-only: the JSON nodeType registry.',
  'StaticResolver': 'model-only, and not an S-prefixed mirror at all.',
};

final _classDecl = RegExp(
  r'^(?:(?:abstract|sealed|final|base|interface|mixin)\s+)*class (\w+)',
  multiLine: true,
);

Future<Directory> _packageLib(String package) async {
  final uri = await Isolate.resolvePackageUri(Uri.parse('package:$package/'));
  if (uri == null) fail('package:$package does not resolve from this package');
  return Directory.fromUri(uri);
}

void main() {
  late Set<String> analyzerClasses;
  late Set<String> modelClasses;

  setUpAll(() async {
    final analyzer = await _packageLib('analyzer');
    final astFile = File('${analyzer.path}src/dart/ast/ast.dart');
    analyzerClasses = {
      for (final m in _classDecl.allMatches(astFile.readAsStringSync()))
        if (!m.group(1)!.endsWith('Impl') && !m.group(1)!.startsWith('_'))
          m.group(1)!,
    };
    final model = await _packageLib('tom_ast_model');
    modelClasses = {
      for (final f in model.listSync(recursive: true).whereType<File>())
        if (f.path.endsWith('.dart'))
          for (final m in _classDecl.allMatches(f.readAsStringSync()))
            if (m.group(1)!.startsWith('S')) m.group(1)!,
    };
  });

  group('SCE218: mirror type names', () {
    test('F-SCE218-1 (control): the oracle reads both sides and discriminates '
        '[2026-09-28] (PASS)', () {
      // 238 analyzer classes and 188 model classes on 2026-09-28. The floors
      // catch a regex that stopped matching modifiers — the exact way the
      // earlier oracles went wrong.
      expect(analyzerClasses.length, greaterThanOrEqualTo(200));
      expect(analyzerClasses, containsAll(['NamedExpression', 'Expression']));
      expect(analyzerClasses, isNot(contains('NamedExpressionImpl')));
      expect(modelClasses.length, greaterThanOrEqualTo(150));
      expect(modelClasses, contains('SNamedExpression'));
    });

    test('F-SCE218-2: every model S-class is S + an analyzer AST name, or '
        'recorded with its reason [2026-09-28] (PASS)', () {
      final unexplained = [
        for (final c in modelClasses.toList()..sort())
          if (!analyzerClasses.contains(c.substring(1)) &&
              !_recorded.containsKey(c))
            c,
      ];
      expect(
        unexplained,
        isEmpty,
        reason:
            'These tom_ast_model classes have no analyzer AST class of the '
            'same name without the S. SCD183 rewrites SFoo -> Foo to compare '
            'the two interpreters, so any interpreter code over them will read '
            'as divergent. Name the model type after the analyzer type, or add '
            'it to _recorded with the reason it cannot be.',
      );
    });

    test('F-SCE218-3: no recorded exception outlives its cause '
        '[2026-09-28] (PASS)', () {
      final stale = [
        for (final c in _recorded.keys)
          if (!modelClasses.contains(c) ||
              analyzerClasses.contains(c.substring(1)))
            c,
      ];
      // SAstVisitor is the one entry whose analyzer name exists outside the
      // oracle file; it never appears in ast.dart, so it is not stale.
      expect(stale, isEmpty, reason: 'remove these from _recorded');
    });
  });
}
