// SCE105/AST — every pattern kind the MODEL has reaches a branch, and the model
// has every kind the reference tree dispatches on.
//
// REPO-WIDE GUARD (tom_d4rt_ast): reads `../tom_ast_model/lib/src/ast/` and
// `../tom_d4rt/lib/src/interpreter_visitor.dart`.
//
// The twin of `tom_d4rt/test/sce105_pattern_kind_coverage_test.dart`, and it
// asks one question that file cannot. That one derives the language's pattern
// kinds from the analyzer's sealed `DartPattern` hierarchy; this package has no
// analyzer — not even as a dev dependency, which is deliberate — so its source
// of truth is `tom_ast_model`, the mirror the interpreter actually receives.
//
// THAT SUBSTITUTION IS THE EXTRA CHECK, not a compromise. A branch can only run
// on a node the model can represent, so a kind the analyzer has and the model
// LACKS is one this interpreter can never receive however many branches it
// grows. F-SCE105-AST-3 is that question, and it is answerable here and nowhere
// else: it compares the model's kinds against the reference tree's dispatch,
// which is derived from the analyzer by the other file.
//
// READ WITH A LINE SCANNER RATHER THAN A PARSE, which the reference file
// deliberately does not do. Its reason for parsing is specific — its own source
// contains every class name it searches for, so a grep over the TREE finds its
// own text — and it does not apply to two named files in other packages. The
// alternative is a dev dependency on the analyzer in the one package whose
// identity is having no dependencies, which is a worse trade for a guard. The
// scanner's failure mode is "finds nothing", and F-SCE105-AST-1 is what turns
// that into a red test rather than a green one.
//
// ABLATED: deleting the `SParenthesizedPattern` branch fails -2 with that kind
// named; adding a fictional baseline entry fails it from the other side;
// renaming a model class fails -3.

@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';
import '../sibling_trees.dart';

/// Pattern kinds with no branch in this tree's `_matchAndBind`, and why.
///
/// EMPTY, as in the reference tree. An entry is a deliberate, named gap, and
/// F-SCE105-AST-2 rejects both an unrecorded gap and a recording whose gap has
/// been closed.
const Map<String, String> _unhandledBaseline = <String, String>{};

final _modelDir = Directory('../tom_ast_model/lib/src/ast');
final _referenceVisitor = File('../tom_d4rt/lib/src/interpreter_visitor.dart');
final _visitor = File('lib/src/runtime/interpreter_visitor.dart');

final _haveSiblings = _modelDir.existsSync() && _referenceVisitor.existsSync();
final _skipReason = _haveSiblings
    ? null
    : 'needs the sibling checkouts ../tom_ast_model and ../tom_d4rt; this '
          'guard is about the repo layout and cannot run from a published '
          'tom_d4rt_ast on its own';

/// `class X extends Y` declarations across [dir], as name -> supertype.
Map<String, String> _modelSupertypes(Directory dir) {
  final pattern = RegExp(
    r'^(?:abstract\s+)?class\s+(\w+)\s+extends\s+(\w+)',
    multiLine: true,
  );
  final result = <String, String>{};
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    for (final match in pattern.allMatches(entity.readAsStringSync())) {
      result[match.group(1)!] = match.group(2)!;
    }
  }
  return result;
}

/// The concrete descendants of [root] in [supertypes].
///
/// A descendant that is itself another descendant's supertype is an abstract
/// intermediate — `SVariablePattern` is the one that exists — and is not a kind
/// a script can write.
Set<String> _concreteKinds(Map<String, String> supertypes, String root) {
  final descendants = <String>{};
  var changed = true;
  while (changed) {
    changed = false;
    supertypes.forEach((name, parent) {
      if (descendants.contains(name)) return;
      if (parent == root || descendants.contains(parent)) {
        descendants.add(name);
        changed = true;
      }
    });
  }
  final intermediates = <String>{
    for (final name in descendants)
      if (descendants.contains(supertypes[name])) supertypes[name]!,
  };
  return descendants.difference(intermediates);
}

/// The `pattern is X` type tests inside `_matchAndBind` in [file].
///
/// Brace-counted from the declaration rather than scanned file-wide: a
/// `pattern is X` elsewhere would report a kind as handled that this dispatch
/// never sees, and over-reporting coverage is the one direction a coverage
/// guard must not fail in.
Set<String> _handledKinds(File file) {
  final source = file.readAsStringSync();
  final start = source.indexOf(RegExp(r'void _matchAndBind\s*\('));
  if (start < 0) return {};
  var depth = 0;
  var i = source.indexOf('{', start);
  if (i < 0) return {};
  final open = i;
  for (; i < source.length; i++) {
    if (source[i] == '{') depth++;
    if (source[i] == '}') {
      depth--;
      if (depth == 0) break;
    }
  }
  final body = source.substring(open, i);
  return {
    for (final m in RegExp(r'pattern is ([A-Z]\w+)').allMatches(body))
      m.group(1)!,
  };
}

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_ast',
    subject: 'reads `../tom_ast_model/lib/src/ast/` and',
  );

  group('SCE105/AST: every pattern kind reaches a branch', () {
    late Set<String> modelKinds;
    late Set<String> handled;
    late Set<String> referenceKinds;

    setUp(() {
      modelKinds = _concreteKinds(_modelSupertypes(_modelDir), 'SDartPattern');
      handled = _handledKinds(_visitor);
      referenceKinds = _handledKinds(_referenceVisitor);
    });

    test('F-SCE105-AST-1 (anti-vacuity): every scan found something '
        '[2026-09-22] (PASS)', () {
      // Asserted before anything is concluded. Three scans feed the cases
      // below and each can silently return empty — a renamed method, a moved
      // model file, a changed declaration style — and an empty set satisfies
      // every comparison built on it.
      expect(
        modelKinds.length,
        greaterThanOrEqualTo(12),
        reason:
            'Only ${modelKinds.length} pattern kinds were derived from '
            'tom_ast_model: $modelKinds. Fifteen when this was written.',
      );
      expect(
        handled.length,
        greaterThanOrEqualTo(12),
        reason:
            'Only ${handled.length} `pattern is X` tests were found in this '
            "tree's _matchAndBind: $handled.",
      );
      expect(
        referenceKinds.length,
        greaterThanOrEqualTo(12),
        reason:
            'Only ${referenceKinds.length} were found in the reference tree: '
            '$referenceKinds.',
      );
    });

    test('F-SCE105-AST-2: the unhandled set is exactly the baseline '
        '[2026-09-22] (PASS)', () {
      final unhandled = modelKinds.difference(handled);
      final appeared = unhandled.difference(_unhandledBaseline.keys.toSet());
      final closed = _unhandledBaseline.keys.toSet().difference(unhandled);
      expect(
        appeared,
        isEmpty,
        reason:
            'These pattern kinds exist in the model and have no branch in '
            '_matchAndBind, so a bundle carrying one dies on it:\n'
            '  ${appeared.join('\n  ')}\n\n'
            'Implement the branch, or record the gap with its reason.',
      );
      expect(
        closed,
        isEmpty,
        reason:
            'These are recorded as unhandled but now have a branch:\n'
            '  ${closed.join('\n  ')}\n\nRemove them from the baseline.',
      );
    });

    test('F-SCE105-AST-3: the model has every kind the reference tree '
        'dispatches on [2026-09-22] (PASS)', () {
      // THE QUESTION ONLY THIS FILE CAN ASK. The reference tree's dispatch is
      // held to the analyzer's hierarchy by the other sce105 guard, so it
      // stands in for the language here. A kind it handles and the model lacks
      // is one this interpreter can never receive — the analyzer-free line
      // would be missing it at the BUNDLE, where no branch can help.
      final missing = referenceKinds
          .map((name) => 'S$name')
          .toSet()
          .difference(modelKinds);
      expect(
        missing,
        isEmpty,
        reason:
            'tom_ast_model has no class for these kinds, which the reference '
            'interpreter dispatches on:\n  ${missing.join('\n  ')}\n\n'
            'Add them to the model first — a branch for a node the model '
            'cannot represent is unreachable, and `tom_ast_generator` has '
            'nothing to emit.',
      );
    });
  }, skip: _skipReason);
}
