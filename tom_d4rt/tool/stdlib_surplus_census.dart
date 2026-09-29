/// Which stdlib adapters can reject a SURPLUS positional argument (SCE245).
///
///     dart run tool/stdlib_surplus_census.dart         # counts, both trees
///     dart run tool/stdlib_surplus_census.dart -v      # ... and every
///                                                      #     unguarded adapter
///
/// REPORTS, NEVER EDITS. It exists because two regex rules for "is this adapter
/// guarded" were written, run over the corpus and shown wrong (SCD204's header
/// records both), and a sweep driven by an unmeasured rule under-reports.
///
/// For every adapter closure `(visitor, [target,] positionalArgs, namedArgs,
/// _)` it establishes, with the analyzer rather than with text:
///
///   * `maxIndex`: the highest literal index read, through `positionalArgs[k]`
///     or `positionalArgs.get<…>(k)`. An adapter that reads none is
///     ZERO-ARGUMENT and outside SCD204's scope (reported as a count).
///   * VARIADIC: the adapter uses the list wholesale (iterates it, spreads it,
///     passes it on, reads it at a non-literal index). A surplus is then not
///     dropped by construction, so it is not a finding.
///   * GUARDED, by either
///       - `D4.checkArity(...)` with `atMost:` or `exactly:`, or
///       - an `if` statement or `?:` whose THROWING branch is definitely
///         selected when `positionalArgs.length == maxIndex + 2`. The condition
///         is evaluated three-valued: integer comparisons against
///         `positionalArgs.length`, `isEmpty` / `isNotEmpty`, `!`, `&&`, `||`
///         and parentheses are decided, and anything else is UNKNOWN. Unknown
///         never counts as a guard. A branch "throws" when it is a `throw`, or a
///         block that contains a top-level `throw` statement.
///   * OPERATOR: the key is an operator (`[]`, `[]=`, `+`, `unary-`, ...).
///     Its arity is fixed by the syntax that reaches it and Dart operators
///     cannot be torn off, so no surplus can arrive.
///   * UNGUARDED otherwise: a surplus positional argument is dropped in
///     silence.
///
/// Conservative by construction: an adapter whose guard is written in a shape
/// the evaluator cannot decide is reported unguarded, never the reverse.
/// That errs toward over-reporting, which a reader can check line by line,
/// rather than the under-reporting both regex rules produced.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';

/// One adapter's verdict.
enum Verdict {
  zeroArgument,
  operator,
  variadic,
  checkArity,
  handGuard,
  unguarded,
}

/// One adapter, located.
class AdapterFinding {
  AdapterFinding(this.file, this.line, this.key, this.maxIndex, this.verdict);
  final String file;
  final int line;
  final String key;
  final int maxIndex;
  final Verdict verdict;
  @override
  String toString() =>
      '$file:$line  ${key.isEmpty ? '<unnamed>' : key}  '
      '(reads up to [$maxIndex])';
}

/// Census of every adapter under [stdlibRoot].
List<AdapterFinding> surplusCensus(String stdlibRoot) {
  final out = <AdapterFinding>[];
  final files =
      Directory(stdlibRoot)
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final file in files) {
    final rel = file.path.substring(stdlibRoot.length + 1);
    final result = parseString(
      content: file.readAsStringSync(),
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    );
    result.unit.accept(_AdapterWalker(rel, result.lineInfo, out));
  }
  return out;
}

class _AdapterWalker extends RecursiveAstVisitor<void> {
  _AdapterWalker(this.file, this.lineInfo, this.out);
  final String file;
  final LineInfo lineInfo;
  final List<AdapterFinding> out;

  @override
  void visitFunctionExpression(FunctionExpression node) {
    final params = node.parameters?.parameters ?? const [];
    final names = [for (final p in params) p.name?.lexeme];
    final isAdapter =
        (names.length == 4 || names.length == 5) &&
        names.first == 'visitor' &&
        names.contains('positionalArgs') &&
        names.contains('namedArgs');
    if (isAdapter) {
      var key = '';
      final parent = node.parent;
      if (parent is MapLiteralEntry && parent.key is SimpleStringLiteral) {
        key = (parent.key as SimpleStringLiteral).value;
      }
      final uses = _ArgUses();
      node.body.accept(uses);
      out.add(
        AdapterFinding(
          file,
          lineInfo.getLocation(node.offset).lineNumber,
          key,
          uses.maxIndex,
          _isOperatorKey(key) ? Verdict.operator : _verdict(uses, node.body),
        ),
      );
      // An adapter's body does not hold further adapters worth counting.
      return;
    }
    super.visitFunctionExpression(node);
  }
}

/// An operator's arity is fixed by the syntax that reaches it (`a[i]`,
/// `a[i] = v`, `a + b`), and Dart operators cannot be torn off, so a surplus
/// cannot arrive. Named `unary-` in the bridges.
bool _isOperatorKey(String key) =>
    key.isNotEmpty && !RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*$').hasMatch(key);

Verdict _verdict(_ArgUses uses, FunctionBody body) {
  if (uses.wholesale) return Verdict.variadic;
  if (uses.maxIndex < 0) return Verdict.zeroArgument;
  if (uses.checkArityBound) return Verdict.checkArity;
  if (_hasHandGuard(body, uses.maxIndex + 2)) return Verdict.handGuard;
  return Verdict.unguarded;
}

class _ArgUses extends RecursiveAstVisitor<void> {
  int maxIndex = -1;
  bool wholesale = false;
  bool checkArityBound = false;

  bool _isArgs(Expression? e) =>
      e is SimpleIdentifier && e.name == 'positionalArgs';

  @override
  void visitIndexExpression(IndexExpression node) {
    if (_isArgs(node.target)) {
      final i = node.index;
      if (i is IntegerLiteral && i.value != null) {
        if (i.value! > maxIndex) maxIndex = i.value!;
      } else {
        wholesale = true;
      }
    }
    super.visitIndexExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final target = node.target;
    final args = node.argumentList.arguments;
    if (target is SimpleIdentifier &&
        target.name == 'D4' &&
        node.methodName.name == 'checkArity' &&
        args.any(
          (a) =>
              a is NamedExpression &&
              (a.name.label.name == 'atMost' || a.name.label.name == 'exactly'),
        )) {
      checkArityBound = true;
    }
    if (_isArgs(target) && node.methodName.name == 'get') {
      final first = args.isEmpty ? null : args.first;
      if (first is IntegerLiteral && first.value != null) {
        if (first.value! > maxIndex) maxIndex = first.value!;
      } else {
        wholesale = true;
      }
    }
    super.visitMethodInvocation(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (node.name == 'positionalArgs') {
      final p = node.parent;
      final benign =
          (p is IndexExpression && identical(p.target, node)) ||
          (p is MethodInvocation &&
              identical(p.target, node) &&
              p.methodName.name == 'get') ||
          (p is PrefixedIdentifier &&
              const {
                'length',
                'isEmpty',
                'isNotEmpty',
              }.contains(p.identifier.name)) ||
          (p is PropertyAccess &&
              const {
                'length',
                'isEmpty',
                'isNotEmpty',
              }.contains(p.propertyName.name)) ||
          // `D4.checkArity(positionalArgs, ...)` and friends only READ the
          // length; they neither consume nor forward the arguments.
          (p is ArgumentList &&
              p.parent is MethodInvocation &&
              (p.parent as MethodInvocation).methodName.name == 'checkArity') ||
          node.parent is FormalParameter ||
          node.parent is SimpleFormalParameter;
      if (!benign) wholesale = true;
    }
    super.visitSimpleIdentifier(node);
  }
}

/// Whether some `if` / `?:` in [body] throws on a call with [length] positional
/// arguments.
bool _hasHandGuard(FunctionBody body, int length) {
  final finder = _GuardFinder(length);
  body.accept(finder);
  return finder.found;
}

class _GuardFinder extends RecursiveAstVisitor<void> {
  _GuardFinder(this.length);
  final int length;
  bool found = false;

  @override
  void visitIfStatement(IfStatement node) {
    final v = _eval(node.expression, length);
    if ((v == true && _throws(node.thenStatement)) ||
        (v == false &&
            node.elseStatement != null &&
            _throws(node.elseStatement!))) {
      found = true;
    }
    super.visitIfStatement(node);
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    final v = _eval(node.condition, length);
    if ((v == true && node.thenExpression is ThrowExpression) ||
        (v == false && node.elseExpression is ThrowExpression)) {
      found = true;
    }
    super.visitConditionalExpression(node);
  }
}

bool _throws(Statement s) {
  if (s is ExpressionStatement && s.expression is ThrowExpression) return true;
  if (s is Block) {
    return s.statements.any(
      (t) => t is ExpressionStatement && t.expression is ThrowExpression,
    );
  }
  return false;
}

/// Three-valued: `true`, `false`, or `null` for unknown.
bool? _eval(Expression e, int length) {
  if (e is ParenthesizedExpression) return _eval(e.expression, length);
  if (e is PrefixExpression && e.operator.type == TokenType.BANG) {
    final v = _eval(e.operand, length);
    return v == null ? null : !v;
  }
  if (e is BinaryExpression) {
    final op = e.operator.type;
    if (op == TokenType.AMPERSAND_AMPERSAND) {
      final l = _eval(e.leftOperand, length);
      final r = _eval(e.rightOperand, length);
      if (l == false || r == false) return false;
      if (l == true && r == true) return true;
      return null;
    }
    if (op == TokenType.BAR_BAR) {
      final l = _eval(e.leftOperand, length);
      final r = _eval(e.rightOperand, length);
      if (l == true || r == true) return true;
      if (l == false && r == false) return false;
      return null;
    }
    final l = _int(e.leftOperand, length);
    final r = _int(e.rightOperand, length);
    if (l == null || r == null) return null;
    return switch (op) {
      TokenType.LT => l < r,
      TokenType.LT_EQ => l <= r,
      TokenType.GT => l > r,
      TokenType.GT_EQ => l >= r,
      TokenType.EQ_EQ => l == r,
      TokenType.BANG_EQ => l != r,
      _ => null,
    };
  }
  final prop = _argsProperty(e);
  if (prop == 'isEmpty') return length == 0;
  if (prop == 'isNotEmpty') return length != 0;
  return null;
}

int? _int(Expression e, int length) {
  if (e is ParenthesizedExpression) return _int(e.expression, length);
  if (e is IntegerLiteral) return e.value;
  if (_argsProperty(e) == 'length') return length;
  return null;
}

String? _argsProperty(Expression e) {
  if (e is PrefixedIdentifier && e.prefix.name == 'positionalArgs') {
    return e.identifier.name;
  }
  if (e is PropertyAccess &&
      e.target is SimpleIdentifier &&
      (e.target as SimpleIdentifier).name == 'positionalArgs') {
    return e.propertyName.name;
  }
  return null;
}

void main(List<String> args) {
  final roots = {
    'tom_d4rt': 'lib/src/stdlib',
    'tom_d4rt_ast': '../tom_d4rt_ast/lib/src/runtime/stdlib',
  };
  for (final MapEntry(key: package, value: root) in roots.entries) {
    final findings = surplusCensus(root);
    final by = <Verdict, List<AdapterFinding>>{};
    for (final f in findings) {
      (by[f.verdict] ??= []).add(f);
    }
    int n(Verdict v) => by[v]?.length ?? 0;
    final reading =
        findings.length - n(Verdict.zeroArgument) - n(Verdict.operator);
    print(
      '$package: ${findings.length} adapters; ${n(Verdict.zeroArgument)} read '
      'no argument, ${n(Verdict.operator)} are operators; of the $reading '
      'other argument-reading ones: ${n(Verdict.checkArity)} '
      'D4.checkArity, ${n(Verdict.handGuard)} hand-written guard, '
      '${n(Verdict.variadic)} variadic, ${n(Verdict.unguarded)} UNGUARDED',
    );
    if (args.contains('-v')) {
      for (final f in by[Verdict.unguarded] ?? const <AdapterFinding>[]) {
        print('  $f');
      }
    }
  }
}
