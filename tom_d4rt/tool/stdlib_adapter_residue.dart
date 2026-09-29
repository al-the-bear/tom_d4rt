/// The stdlib adapters whose risk no existing guard covers (SCE226).
///
///     dart run tool/stdlib_adapter_residue.dart        # the counts
///     dart run tool/stdlib_adapter_residue.dart -v     # ... and every adapter
///
/// SCD189 classified the stdlib adapter bodies by four risk markers and found
/// 1 039 carrying one — too many to act on. Each marker already has a guard, so
/// the number worth deciding on is the RESIDUE: marked adapters the guard does
/// not reach. A marker is covered when:
///
///   * coerces an argument — the adapter goes through `D4.coerce*` /
///     `D4.adapt*`. A cast of an argument to a TOP-TYPE container (`as List`,
///     `as Iterable<dynamic>`) is not a coercion risk: SCD70 established those
///     always succeed, and bans exactly the parameterised casts that can fail.
///   * adapts a callback — it handles the callback as `Callable` (directly, via
///     `D4.callInterpreterCallback` / `runAction`, or through a file-local
///     `_callback` helper that narrows to `Callable`), which is SCD35's rule.
///   * branches on arity — it bounds SURPLUS arguments: `D4.checkArity(...)`, or
///     a test that rejects too many (`== N`, `!= N`, `> N`, `isNotEmpty`) in a
///     body that throws. Too-FEW is handled for every adapter at dispatch
///     (`D4.describeArityError`, SCB28), so it is not part of the question.
///   * constructs a result — its member is probed by SCC24 / SCD36, or driven
///     by a script in the test corpus.
///
/// Measured 2026-09-29, `tom_d4rt` 1.195.0 (the stdlib twins are code-
/// identical, so the AST tree has the same set): 2 980 adapters; the residue is
/// 123 adapter entries (107 distinct file+member names), ALL of them arity — adapters that discard surplus positional arguments
/// in silence (`stream.asyncMap(f, 99)`, `stream.contains(1, 2)`,
/// `Error.safeToString(1, 2)`), the SCD204 defect in files SCC85's sweep did not
/// reach. Callback, coercion and construction come to zero once the rules
/// above are applied. scf36 owns closing the 123.
///
/// THE ARITY FIGURE BELOW IS SUPERSEDED (SCE245). Its rule, a surplus test
/// plus any `throw` in the body, is one of the two regex rules SCD204 showed
/// to under-report. The analyzer census, `tool/stdlib_surplus_census.dart`,
/// measured 315 adapters per tree that drop a surplus (2026-09-29), not 123.
/// The callback, coercion and construction figures are unaffected.
///
/// A MEASUREMENT, NOT A GUARD. SCD204 explains why a whole-stdlib arity guard is
/// harder than it looks; this is regex over adapter source and is advice.
library;

import 'dart:io';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

const _maps = {
  'methods',
  'getters',
  'setters',
  'staticMethods',
  'staticGetters',
  'staticSetters',
  'constructors',
};
final coerce = RegExp(
  r'D4\.coerce|D4\.adapt|(positionalArgs\[\d+\]|namedArgs\[[^\]]+\])\)?\s+as\s+(List|Map|Set|Iterable|Stream|Sink|StreamConsumer)\b',
);
final coerceHelper = RegExp(r'D4\.coerce|D4\.adapt');

/// A cast of an argument to a container WITH a non-top type argument — the
/// shape SCD70 bans; a raw or `<dynamic>`/`<Object?>` cast always succeeds.
final parameterisedArgCast = RegExp(
  r'(positionalArgs\[\d+\]|namedArgs\[[^\]]+\])\)?\s+as\s+(List|Map|Set|Iterable|Stream|Sink|StreamConsumer)<(?!dynamic>|Object\?>)',
);
final callback = RegExp(
  r'\bCallable\b|callInterpreterCallback|InterpretedFunction|runAction|\.call\(\s*visitor',
);
final callbackCovered = RegExp(
  r'\bCallable\b|callInterpreterCallback|runAction|_callback\(',
);
final arity = RegExp(
  r'positionalArgs\.(length|isEmpty|isNotEmpty)|checkArity|namedArgs\.containsKey',
);
final arityCovered = RegExp(r'D4\.checkArity\(');
final surplusTest = RegExp(
  r'positionalArgs\.length\s*(==|!=|>=|>)\s*\d+|positionalArgs\.isNotEmpty|positionalArgs\.length\s*<=\s*\d+',
);
final constructs = RegExp(
  r'BridgedInstance\(|toBridgedInstance|=>\s*\[|return\s*\[|=>\s*\{|return\s*\{|\.toList\(\)|Map\.of|List\.of|List\.from|Map\.from',
);

void main(List<String> args) {
  final probeNames = <String>{};
  for (final t in [
    'test/scc24_native_name_coverage_test.dart',
    ...Directory('test')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.contains('scd36'))
        .map((f) => f.path),
  ]) {
    final s = File(t).readAsStringSync();
    for (final m in RegExp(r"_Probe\(\s*'(\w+)").allMatches(s)) {
      probeNames.add(m.group(1)!);
    }
  }
  final testCorpus = Directory('test')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .map((f) => f.readAsStringSync())
      .join('\n');
  var total = 0, pure = 0, marked = 0;
  final byMarker = <String, int>{};
  final residue = <String, List<String>>{};
  for (final f
      in Directory('lib/src/stdlib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
    final unit = parseString(
      content: f.readAsStringSync(),
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    ).unit;
    unit.accept(
      _W((map, key, body) {
        total++;
        final src = body.toSource();
        final ms = <String>[];
        if (coerce.hasMatch(src)) ms.add('coerce');
        if (callback.hasMatch(src)) ms.add('callback');
        if (arity.hasMatch(src)) ms.add('arity');
        if (constructs.hasMatch(src)) ms.add('constructs');
        if (ms.isEmpty) {
          pure++;
          return;
        }
        marked++;
        for (final m in ms) {
          byMarker[m] = (byMarker[m] ?? 0) + 1;
          final covered = switch (m) {
            'coerce' =>
              coerceHelper.hasMatch(src) || !parameterisedArgCast.hasMatch(src),
            'callback' => callbackCovered.hasMatch(src),
            'arity' =>
              arityCovered.hasMatch(src) ||
                  (surplusTest.hasMatch(src) && src.contains('throw')),
            'constructs' =>
              probeNames.contains(key) ||
                  (key.isNotEmpty && testCorpus.contains('.$key(')) ||
                  (key.isEmpty &&
                      File(
                        'test/stdlib/${f.path.substring('lib/src/stdlib/'.length).replaceFirst('.dart', '_test.dart')}',
                      ).existsSync()),
            _ => false,
          };
          if (!covered) {
            residue
                .putIfAbsent(m, () => [])
                .add('${f.path.substring('lib/src/stdlib/'.length)} $map.$key');
          }
        }
      }),
    );
  }
  print('adapters $total  pure $pure  marked $marked');
  byMarker.forEach(
    (k, v) => print('  $k: $v marked, ${residue[k]?.length ?? 0} not covered'),
  );
  final all = <String>{};
  residue.values.forEach(all.addAll);
  print('residue (distinct adapters) ${all.length}');
  if (args.contains('-v')) {
    residue.forEach((k, v) {
      print('== $k');
      v.take(400).forEach(print);
    });
  }
}

class _W extends RecursiveAstVisitor<void> {
  _W(this.cb);
  final void Function(String, String, AstNode) cb;
  @override
  void visitNamedExpression(NamedExpression n) {
    final k = n.name.label.name;
    final e = n.expression;
    if (_maps.contains(k) && e is SetOrMapLiteral) {
      for (final el in e.elements) {
        if (el is MapLiteralEntry &&
            el.key is SimpleStringLiteral &&
            el.value is FunctionExpression) {
          cb(
            k,
            (el.key as SimpleStringLiteral).value,
            (el.value as FunctionExpression).body,
          );
        }
      }
    }
    super.visitNamedExpression(n);
  }
}
