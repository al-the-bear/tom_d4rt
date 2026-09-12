// SCD67 — every supertype edge is one SDK hop, and stays that way.
//
// The `_supertypeRegistry` blocks used to restate whole closures:
// `'IndexError': ['RangeError', 'ArgumentError', 'Error']` where the SDK says
// `class IndexError extends RangeError` and the other two are already
// reachable. That was not a style choice. Until SCC19 the registry walk went
// only one hop past the direct supertypes, so a two-hop answer had to be
// written out — and the comment explaining that constraint outlived it by
// months, in a file whose next reader would have copied the shape.
//
// SCD67 swept the three blocks that still carried it: `dart:async`'s
// `StreamController`, `dart:typed_data`'s eleven list views, and the
// `dart:core` error chain. Measured, the sweep removed exactly 18 redundant
// edges — 155 direct edges became 137 — and changed no closure.
//
// THIS GUARD IS WHY THE SWEEP IS WORTH MAKING. De-flattening is cosmetic on
// its own: nothing was wrong, only redundant, and a redundancy that nobody
// checks comes back the first time somebody adds a converter by copying the
// line above it. The invariant is derivable rather than recorded, so there is
// no baseline to rot: a parent that is already reachable through another
// parent of the same key does not belong in that key's list.
//
// EACH CASE OBSERVED. Run against the tree as it stood before the sweep
// (`git archive HEAD | …`), F-SCD67-2 reports all 18, by name. Against a
// parser pointed at a directory with no registrar in it, F-SCD67-1 fires —
// which is the failure that matters most here, because a parser that finds
// nothing reports "no redundant edges" and looks exactly like success.
//
// BOTH TREES, ONE GUARD, for the same reason `scd49_stdlib_twin_sync_test.dart`
// reaches across: the mirror rule means the twin holds the same file, and one
// invariant should not have two enforcers that could disagree. That file
// already asserts the two stdlib trees are code-identical, so this one does not
// re-assert it — it asks the semantic question of each tree independently, and
// would catch a divergence introduced while the file-identity allow-list was
// being widened for some other reason.

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

/// The reference tree's stdlib, relative to the package root.
const _refRoot = 'lib/src/stdlib';

/// The analyzer-free twin's, reached across the package boundary.
const _astRoot = '../tom_d4rt_ast/lib/src/runtime/stdlib';

/// Measured 2026-09-12: 120 keys and 137 edges in each tree, after the sweep.
/// The floors sit well below that — they are here to catch a parser that
/// stopped matching, not to pin the registry's size.
const _minKeys = 90;
const _minEdges = 110;

/// `name -> the parents its registrar declares directly`.
///
/// Collected by PARSING rather than by matching text: the blocks are dense with
/// prose comments that quote SDK declarations, and a regex over the file would
/// read `// 'Foo': ['Bar']` in a comment as an edge. The analyzer discards
/// comments before this code ever sees them.
Map<String, Set<String>> directEdges(String root) {
  final edges = <String, Set<String>>{};
  final dir = Directory(root);
  if (!dir.existsSync()) return edges;
  for (final file
      in dir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
    final unit = parseString(
      content: file.readAsStringSync(),
      throwIfDiagnostics: false,
    ).unit;
    unit.accept(_RegistrarVisitor(edges));
  }
  return edges;
}

/// Collects the map literal passed to every `registerSupertypes(...)` call.
class _RegistrarVisitor extends RecursiveAstVisitor<void> {
  _RegistrarVisitor(this.edges);

  final Map<String, Set<String>> edges;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);
    if (node.methodName.name != 'registerSupertypes') return;
    final args = node.argumentList.arguments;
    if (args.length != 1) return;
    final literal = args.first;
    if (literal is! SetOrMapLiteral) return;
    for (final element in literal.elements) {
      if (element is! MapLiteralEntry) continue;
      final key = _stringOf(element.key);
      final value = element.value;
      if (key == null || value is! ListLiteral) continue;
      for (final parent in value.elements) {
        final name = _stringOf(parent);
        if (name != null) (edges[key] ??= <String>{}).add(name);
      }
    }
  }

  static String? _stringOf(AstNode node) =>
      node is SimpleStringLiteral ? node.value : null;
}

/// Everything reachable from [name], optionally ignoring one direct parent.
///
/// [without] is the whole trick: asking whether a parent is reachable WITHOUT
/// being named directly is what distinguishes a redundant restatement from the
/// only edge that supplies it.
Set<String> reachable(
  Map<String, Set<String>> edges,
  String name, {
  String? without,
}) {
  final seen = <String>{};
  final stack = [
    for (final parent in edges[name] ?? const <String>{})
      if (parent != without) parent,
  ];
  while (stack.isNotEmpty) {
    final next = stack.removeLast();
    if (!seen.add(next)) continue;
    stack.addAll(edges[next] ?? const <String>{});
  }
  return seen;
}

void main() {
  final trees = {
    'tom_d4rt': directEdges(_refRoot),
    'tom_d4rt_ast': directEdges(_astRoot),
  };

  group('SCD67: supertype edges are single hops', () {
    test('F-SCD67-1: the parse read a real registry in both trees '
        '[2026-09-12] (PASS)', () {
      // F-SCD67-2 reports redundancy; with nothing parsed it reports none,
      // and reads as a clean bill of health. This is the case that makes
      // that impossible.
      trees.forEach((tree, edges) {
        final edgeCount = edges.values.fold(0, (n, set) => n + set.length);
        expect(
          edges.length,
          greaterThanOrEqualTo(_minKeys),
          reason:
              'Only ${edges.length} registry keys parsed from $tree. That is '
              'not a finding about the hierarchy — the walk or the parse '
              'stopped matching, and every key would then read as '
              'non-redundant by absence.',
        );
        expect(
          edgeCount,
          greaterThanOrEqualTo(_minEdges),
          reason: 'Only $edgeCount direct edges parsed from $tree.',
        );
      });
    });

    test('F-SCD67-2: no key restates an edge another of its parents already '
        'reaches [2026-09-12] (PASS)', () {
      final redundant = <String>[];
      trees.forEach((tree, edges) {
        for (final entry in edges.entries) {
          final parents = entry.value.toList()..sort();
          for (final parent in parents) {
            if (!reachable(
              edges,
              entry.key,
              without: parent,
            ).contains(parent)) {
              continue;
            }
            redundant.add(
              '$tree  ${entry.key}: `$parent` is already reached through '
              '${parents.where((p) => p != parent).toList()}',
            );
          }
        }
      });
      expect(
        redundant,
        isEmpty,
        reason:
            'These rows restate a closure the registry already computes:\n'
            '${redundant.join('\n')}\n\n'
            'Declare one edge per SDK `implements`/`extends` and let '
            '`transitiveSupertypeNames` do the rest. Restating is not wrong — '
            'the closure is the same either way — but it makes each block a '
            'hand-maintained closure that a reader has to diff against the '
            'SDK, and the next person adds their class by copying the line '
            'above it.',
      );
    });
  });
}
