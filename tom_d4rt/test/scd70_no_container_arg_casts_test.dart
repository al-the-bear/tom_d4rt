// SCD70 — a bridge adapter never CASTS an argument to a parameterised
// container.
//
// `positionalArgs[0] as List<int>` cannot succeed for anything a script built.
// A list literal written in a script is a `List<Object?>` whatever its elements
// hold and whatever the author annotated, because the interpreter checks the
// element type without reifying it; the same is true of maps, which arrive as
// `Map<Object?, Object?>`. So every such cast was dead code for scripts and
// live only for a value that came back already typed from a native bridge.
//
// SEVENTEEN SITES WERE FOUND THIS WAY, against a todo that named two. Five in
// `io/socket.dart`, four in `io/file.dart`, one each in `io/stdio.dart`,
// `io/io_sink.dart` and `isolate/isolate.dart`, four in `io/http.dart`, and one
// in `core/function.dart` — `Function.apply`, which is not io at all. Each was
// independently unusable, and a reader fixing the two named ones would have
// left fifteen identical twins in files they had open.
//
// THE RULE IS DERIVABLE, which is why this is a guard and not a list. A cast to
// a container whose type arguments are not top types is a claim the interpreter
// cannot satisfy. Casts to `List<Object?>`, `Iterable<dynamic>` and friends are
// fine and are left alone — they are the same statement with a top type, and
// they succeed.
//
// WHAT IT DOES NOT BAN, deliberately:
//
//   * `(arg as List).cast<int>()` — the working idiom this stdlib already uses
//     in a dozen places, and the REQUIRED one for an out-parameter: `readInto`
//     hands the native the caller's buffer, so it must be a writable view and
//     not a converted copy. `D4.coerceList` there returns the byte count and
//     leaves the script's list untouched, which is quieter than the cast error
//     it replaced and worse.
//   * casts of a NON-argument expression. The ban is about values the
//     interpreter produced; a cast of something a native call returned is a
//     different claim and usually a true one.
//
// EACH CASE OBSERVED. Against the trees as they stood, F-SCD70-8 reports all
// seventeen per tree by file and line — thirty-four rows, which is also the
// check that the two trees held the same defect rather than one of them. Pointed at a directory with no adapters in it,
// F-SCD70-7 fires — the case that matters most, because a walk that finds
// nothing reports no violations and reads exactly like a clean tree. That is
// the third guard this quest has written where the anti-vacuity case caught a
// real mistake during development rather than hypothetically.

import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

const _refRoot = 'lib/src/stdlib';
const _astRoot = '../tom_d4rt_ast/lib/src/runtime/stdlib';

/// Measured 2026-09-12: 320 `as` expressions over adapter arguments in each
/// tree. The floor catches a walk that stopped matching.
const _minArgumentCasts = 200;

/// The containers whose type arguments the interpreter erases.
const _containers = {'List', 'Map', 'Set', 'Iterable'};

/// Type names that a cast may safely mention, because every value inhabits
/// them.
const _topTypes = {'Object', 'dynamic'};

typedef Cast = ({String file, int line, String text});

/// Every `as` over an adapter argument, split into the ones that name a
/// parameterised container with a non-top argument and the rest.
({List<Cast> offending, int total}) argumentCasts(String root) {
  final offending = <Cast>[];
  var total = 0;
  final dir = Directory(root);
  if (!dir.existsSync()) return (offending: offending, total: 0);
  for (final file
      in dir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
    final parsed = parseString(
      content: file.readAsStringSync(),
      throwIfDiagnostics: false,
    );
    final visitor = _CastVisitor(file.path.replaceFirst('$root/', ''), parsed);
    parsed.unit.accept(visitor);
    total += visitor.total;
    offending.addAll(visitor.offending);
  }
  return (offending: offending, total: total);
}

class _CastVisitor extends RecursiveAstVisitor<void> {
  _CastVisitor(this.file, this.parsed);

  final String file;
  final ParseStringResult parsed;
  final offending = <Cast>[];
  var total = 0;

  @override
  void visitAsExpression(AsExpression node) {
    super.visitAsExpression(node);
    if (!_readsAnArgument(node.expression)) return;
    total++;
    final type = node.type;
    if (type is! NamedType) return; // function / record types: not this rule.
    if (!_containers.contains(type.name.lexeme)) return;
    final args = type.typeArguments?.arguments;
    if (args == null || args.isEmpty) return; // `as List` is fine.
    final nonTop = args.where((a) {
      if (a is! NamedType) return true;
      // `Object?` is a top type; bare `Object` is not, but a cast to
      // `List<Object>` is still a claim about elements, so it counts.
      return !(_topTypes.contains(a.name.lexeme) && a.question != null) &&
          a.name.lexeme != 'dynamic';
    });
    if (nonTop.isEmpty) return;
    offending.add((
      file: file,
      line: parsed.lineInfo.getLocation(node.offset).lineNumber,
      text: node.toSource(),
    ));
  }

  /// True when [expression] reads out of the adapter's argument containers.
  static bool _readsAnArgument(Expression expression) {
    var node = expression;
    while (true) {
      if (node is IndexExpression) {
        final target = node.target;
        if (target is SimpleIdentifier &&
            (target.name == 'positionalArgs' || target.name == 'namedArgs')) {
          return true;
        }
        node = target ?? node.index;
        continue;
      }
      if (node is SimpleIdentifier) {
        return node.name == 'positionalArgs' || node.name == 'namedArgs';
      }
      return false;
    }
  }
}

void main() {
  final trees = {
    'tom_d4rt': argumentCasts(_refRoot),
    'tom_d4rt_ast': argumentCasts(_astRoot),
  };

  group('SCD70: adapter arguments are coerced, not cast', () {
    test('F-SCD70-7: the walk found the adapters in both trees '
        '[2026-09-12] (PASS)', () {
      trees.forEach((tree, result) {
        expect(
          result.total,
          greaterThanOrEqualTo(_minArgumentCasts),
          reason:
              'Only ${result.total} argument casts found in $tree. That is '
              'not a finding about the bridges — the walk stopped matching, '
              'and every adapter would read as clean by absence.',
        );
      });
    });

    test('F-SCD70-8: no argument is cast to a parameterised container '
        '[2026-09-12] (PASS)', () {
      final all = <String>[
        for (final entry in trees.entries)
          for (final cast in entry.value.offending)
            '${entry.key}  ${cast.file}:${cast.line}  ${cast.text}',
      ];
      expect(
        all,
        isEmpty,
        reason:
            'These casts can never succeed for a value a script built — a '
            'script\'s list is a `List<Object?>` and its map a '
            '`Map<Object?, Object?>`, whatever the elements hold and whatever '
            'was annotated:\n${all.join('\n')}\n\n'
            'Use `D4.coerceList<T>` / `D4.coerceMap<K, V>`, which unwrap '
            'bridged elements and report a bad one by parameter name. The '
            'exception is an OUT parameter such as `readInto`, where the '
            'native writes into the caller\'s list: there use '
            '`(arg as List).cast<T>()`, a writable view, because a coerced '
            'copy silently discards what the native wrote into it.',
      );
    });
  });
}
